import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';
import 'package:sweater/main.dart';
import 'package:sweater/repository/source/remote/model/fcst.dart';
import 'package:sweater/view/widget/loading_widget.dart';
import 'package:sweater/view/widget/main/main_grid_view_widget.dart';
import 'package:sweater/view/widget/main/main_today_list_view_widget.dart';
import 'package:sweater/view/widget/main/main_top_widget.dart';
import 'package:sweater/view/widget/main/main_weeks_list_view_widget.dart';
import 'package:sweater/viewmodel/weather_main_view_model.dart';
import 'package:workmanager/workmanager.dart';



class WeatherMainScreen extends StatefulWidget {
  const WeatherMainScreen({Key? key}) : super(key: key);

  @override
  State<WeatherMainScreen> createState() => _WeatherMainScreenState();
}

class _WeatherMainScreenState extends State<WeatherMainScreen> {
  final ScrollController _controller = ScrollController();


  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        isScrollDown = _controller.offset > 0.0;
      });
    });
    HomeWidget.setAppGroupId('YOUR_GROUP_ID');
    HomeWidget.registerBackgroundCallback(backgroundCallback);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkForWidgetLaunch();
    HomeWidget.widgetClicked.listen(_launchedFromWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future _updateWidget() async {
    try {
      return HomeWidget.updateWidget(
          name: 'HomeWidgetExampleProvider', iOSName: 'HomeWidgetExample');
    } on PlatformException catch (exception) {
      debugPrint('Error Updating Widget. $exception');
    }
  }

  Future _loadData() async {
    try {
      return Future.wait([
        HomeWidget.getWidgetData<String>('title', defaultValue: 'Default Title')
            .then((value) => _titleController.text = value ?? ''),
        HomeWidget.getWidgetData<String>('message',
            defaultValue: 'Default Message')
            .then((value) => _messageController.text = value ?? ''),
      ]);
    } on PlatformException catch (exception) {
      debugPrint('Error Getting Data. $exception');
    }
  }

  void _checkForWidgetLaunch() {
    HomeWidget.initiallyLaunchedFromHomeWidget().then(_launchedFromWidget);
  }

  void _launchedFromWidget(Uri? uri) {
    if (uri != null) {
      showDialog(
          context: context,
          builder: (buildContext) => AlertDialog(
            title: const Text('App started from HomeScreenWidget'),
            content: Text('Here is the URI: $uri'),
          ));
    }
  }

  void _startBackgroundUpdate() {
    Workmanager().registerPeriodicTask('1', 'widgetBackgroundUpdate',
        frequency: Duration(minutes: 15));
  }

  void _stopBackgroundUpdate() {
    Workmanager().cancelByUniqueName('1');
  }

  bool isScrollDown = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WeatherMainViewModel>();
    final state = viewModel.state;

    Future _sendData() async {
      try {
        return Future.wait([
          HomeWidget.saveWidgetData<String>('title', viewModel.state.address?.region1depthName ?? '',),
          HomeWidget.saveWidgetData<String>('message', '${viewModel.state.todayTmpList[0].fcstValue ?? ''}°'),
          HomeWidget.saveWidgetData<String>('status', viewModel.state.skyList.isNotEmpty ? viewModel.state.skyList[0].fcstValue ?? '' : '',),
          HomeWidget.saveWidgetData<String>('min_max', '${_getTemperatureFromFcst(viewModel.state.tmnList)} / ${_getTemperatureFromFcst(viewModel.state.tmxList)}'),
          HomeWidget.renderFlutterWidget(
            const Icon(
              Icons.flutter_dash,
              size: 200,
            ),
            logicalSize: Size(200, 200),
            key: 'dashIcon',
          ),
        ]);
      } on PlatformException catch (exception) {
        debugPrint('Error Sending Data. $exception');
      }
    }

    Future<void> _sendAndUpdate() async {
      await _sendData();
      await _updateWidget();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              direction: Axis.vertical,
              children: [
                InkWell(
                  onTap: _sendAndUpdate,
                  child: MainTopWidget(
                    state: state,
                    isScrollDown: isScrollDown,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView(
                    controller: _controller,
                    children: [
                      MainTodayListViewWidget(state: state),
                      MainWeeksListViewWidget(state: state),
                      MainGridViewWidget(state: state),
                    ],
                  ),
                )
              ],
            ),
            if (state.isLoading) const LoadingWidget(),
          ],
        ),
      ),
    );
  }

  String _getTemperatureFromFcst(List<Fcst> fcstList) {
    if (fcstList.isNotEmpty) {
      Fcst fcst = fcstList[0];
      return '${fcst.fcstValue?.substring(0, fcst.fcstValue!.length - 2) ?? ''}°';
    }
    return '';
  }
}

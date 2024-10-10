import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/view/widget/loading_widget.dart';
import 'package:sweater/view/widget/main/main_grid_view_widget.dart';
import 'package:sweater/view/widget/main/main_today_list_view_widget.dart';
import 'package:sweater/view/widget/main/main_top_widget.dart';
import 'package:sweater/view/widget/main/main_weeks_list_view_widget.dart';
import 'package:sweater/viewmodel/weather_main_view_model.dart';

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
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  bool isScrollDown = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WeatherMainViewModel>();
    final state = viewModel.state;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              direction: Axis.vertical,
              children: [
                MainTopWidget(
                  state: state,
                  isScrollDown: isScrollDown,
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
}

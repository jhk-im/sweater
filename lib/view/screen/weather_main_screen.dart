import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/view/widget/loading_widget.dart';
import 'package:sweater/view/widget/main_top_widget.dart';
import 'package:sweater/view/widget/weeks_list_view_widget.dart';
import 'package:sweater/viewmodel/weather_main_view_model.dart';

class WeatherMainScreen extends StatelessWidget {
  const WeatherMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WeatherMainViewModel>();
    final state = viewModel.state;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainTopWidget(state: state),
                Expanded(
                  child: WeeksListViewWidget(state: state),
                ),
              ],
            ),
            if (state.isLoading) const LoadingWidget(),
          ],
        ),
      ),
    );
  }
}

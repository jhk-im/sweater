import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/view/widget/loading_widget.dart';
import 'package:sweater/view/widget/main_grid_view_widget.dart';
import 'package:sweater/view/widget/main_top_widget.dart';
import 'package:sweater/view/widget/main_weeks_list_view_widget.dart';
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
            Flex(
              mainAxisAlignment: MainAxisAlignment.center,
              direction: Axis.vertical,
              children: [
                MainTopWidget(
                  state: state,
                ),
                Expanded(
                  flex: 1,
                  child: ListView(
                    children: [
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

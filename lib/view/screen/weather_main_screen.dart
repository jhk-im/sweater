import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/viewmodel/weather_main_view_model.dart';

class WeatherMainScreen extends StatelessWidget {
  const WeatherMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WeatherMainViewModel>();
    final state = viewModel.state;
    return const Scaffold();
  }
}

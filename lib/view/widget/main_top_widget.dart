import 'package:flutter/material.dart';
import 'package:sweater/repository/source/remote/model/fcst.dart';
import 'package:sweater/repository/source/remote/model/ncst.dart';
import 'package:sweater/utils/text_styles.dart';
import 'package:sweater/viewmodel/weather_main_state.dart';

class MainTopWidget extends StatelessWidget {
  const MainTopWidget({
    super.key,
    required this.state,
  });

  final WeatherMainState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0,),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.address?.region1depthName ?? '',
              style: title100(context),
            ),
            Text(
              _getTemperatureFromNcst(state.ncstList),
              style: largeTitleBold(context),
            ),
            Text(
              state.skyList.isNotEmpty ? state.skyList[0].fcstValue ?? '' : '',
              style: body(context),
            ),
            Text(
              '${_getTemperatureFromFcst(state.tmnList)} / ${_getTemperatureFromFcst(state.tmxList)}',
              style: body(context),
            ),
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

  String _getTemperatureFromNcst(List<Ncst> ncstList) {
    if (ncstList.isNotEmpty) {
      for (Ncst ncst in ncstList) {
        if (ncst.category == 'T1H') {
          return '${ncst.obsrValue?.substring(0, ncst.obsrValue!.length - 2) ?? ''}°';
        }
      }
    }
    return '';
  }
}

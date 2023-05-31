import 'package:flutter/material.dart';
import 'package:sweater/repository/source/remote/model/fcst.dart';
import 'package:sweater/utils/images.dart';
import 'package:sweater/utils/text_styles.dart';
import 'package:sweater/viewmodel/weather_main_state.dart';

class MainTodayListViewWidget extends StatelessWidget {
  const MainTodayListViewWidget({super.key, required this.state});

  final WeatherMainState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        child: SizedBox(
          height: 150.0,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 24,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 64.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          state.todayTmpList.isNotEmpty
                              ? '${state.todayTmpList[index].fcstTime?.substring(0, 2)}시'
                              : '',
                          style: caption2(context, 1.0),
                        ),
                        if (_getSkyStatus(state.todaySkyList, index).isNotEmpty)
                          pngIcon(_getSkyStatus(state.todaySkyList, index),
                            Theme.of(context).colorScheme.onBackground,
                              width: 18, height: 18),
                        Text(
                          state.todayTmpList.isNotEmpty
                              ? '${state.todayTmpList[index].fcstValue ?? ''}°'
                              : '',
                          style: caption1(context, 1.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (_getPrecipitation(state.todayPopList, index).isNotEmpty)
                            pngIcon('rainy.png',
                                Theme.of(context).colorScheme.onBackground,
                                width: 14, height: 14),
                            Text(_getPrecipitation(state.todayPopList, index),
                                style: caption3(context, 1.0),),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  String _getPrecipitation(List<Fcst> popList, int index) {
    final fcstValue =
    popList.isNotEmpty ? popList[index].fcstValue ?? '' : '';
    if (fcstValue == '0') {
      return '';
    } else {
      return '$fcstValue%';
    }
  }

  String _getSkyStatus(List<Fcst> skyList, int index) {
    String fcstValue = skyList.isNotEmpty ? skyList[index].fcstValue ?? '' : '';
    if (fcstValue.contains('맑') || fcstValue.contains('1')) {
      return 'sunny.png';
    } else if (fcstValue.contains('흐') || fcstValue.contains('4')) {
      return 'cloudy.png';
    } else if (fcstValue.contains('많') || fcstValue.contains('3')) {
      return 'cloudy_day.png';
    }
    return '';
  }
}

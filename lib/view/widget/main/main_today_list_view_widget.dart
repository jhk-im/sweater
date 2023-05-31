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
          height: 200.0,
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
                          state.todayTmpList.isNotEmpty && !state.todayTmpList[index].fcstTime!.contains('일')
                              ? '${state.todayTmpList[index].fcstTime?.substring(0, 2)}시'
                              : state.todayTmpList.isNotEmpty ? state.todayTmpList[index].fcstTime ?? '' : '',
                          style: caption2(context, 1.0),
                        ),
                        if (_getSkyStatus(state.todaySkyList, index).isNotEmpty)
                          pngIcon(_getSkyStatus(state.todaySkyList, index),
                            Theme.of(context).colorScheme.onBackground,
                              width: 18, height: 18),
                        Text(
                          state.yesterdayTmpList.isNotEmpty && !state.yesterdayTmpList[index].fcstTime!.contains('일')
                              ? '${state.yesterdayTmpList[index].fcstValue ?? ''}°'
                              : state.yesterdayTmpList.isNotEmpty ? '${int.parse(state.yesterdayTmpList[index].fcstValue?.substring(0, 2) ?? '0')}:${state.yesterdayTmpList[index].fcstValue?.substring(2, 4)}' : '',
                          style: caption1(context, 0.3),
                        ),
                        Text(
                          state.todayTmpList.isNotEmpty && !state.todayTmpList[index].fcstTime!.contains('일')
                              ? '${state.todayTmpList[index].fcstValue ?? ''}°'
                              : state.todayTmpList.isNotEmpty ? '${int.parse(state.todayTmpList[index].fcstValue?.substring(0, 2) ?? '0')}:${state.todayTmpList[index].fcstValue?.substring(2, 4)}' : '',
                          style: caption1(context, 1.0),
                        ),
                        Text(
                          state.tomorrowTmpList.isNotEmpty && !state.tomorrowTmpList[index].fcstTime!.contains('일')
                              ? '${state.tomorrowTmpList[index].fcstValue ?? ''}°'
                              : state.tomorrowTmpList.isNotEmpty ? '${int.parse(state.tomorrowTmpList[index].fcstValue?.substring(0, 2) ?? '0')}:${state.tomorrowTmpList[index].fcstValue?.substring(2, 4)}' : '',
                          style: caption1(context, 0.5),
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
    final time = int.parse(skyList.isNotEmpty ? skyList[index].fcstTime?.substring(0, 2) ?? '0' : '0');

    int sunrise = 5;
    int sunset = 19;
    if (state.riseSet != null) {
      sunrise = int.parse(state.riseSet!.sunrise?.substring(0, 2) ?? '05');
      sunset = int.parse(state.riseSet!.sunset?.substring(0, 2) ?? '19');
    }

    String fcstValue = skyList.isNotEmpty ? skyList[index].fcstValue ?? '' : '';

    if (fcstValue.contains('일출')) {
      return 'sunrise.png';
    } else if (fcstValue.contains('일몰')) {
      return 'sunset.png';
    } else if (fcstValue.contains('맑') || fcstValue.contains('1')) {
      if (time > sunrise && time <= sunset) {
        return 'sunny.png';
      } else {
        return 'moon.png';
      }
    } else if (fcstValue.contains('흐') || fcstValue.contains('4')) {
      return 'cloudy.png';
    } else if (fcstValue.contains('많') || fcstValue.contains('3')) {
      if (time > sunrise && time <= sunset) {
        return 'cloudy_day.png';
      } else {
        return 'cloudy_night.png';
      }
    }
    return '';
  }
}

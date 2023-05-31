import 'package:flutter/material.dart';
import 'package:sweater/utils/images.dart';
import 'package:sweater/utils/text_styles.dart';
import 'package:sweater/viewmodel/weather_main_state.dart';

class MainWeeksListViewWidget extends StatelessWidget {
  MainWeeksListViewWidget({
    super.key,
    required this.state,
  });

  final WeatherMainState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.tmnList.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: double.infinity,
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        _getDay(index),
                        style: index == 0
                            ? caption1(context, 0.5)
                            : caption1(context, 1.0),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (_getPrecipitation(index).isNotEmpty)
                            pngIcon('rainy.png',
                                Theme.of(context).colorScheme.onBackground,
                                width: 14, height: 14),
                          Text(_getPrecipitation(index),
                              style: caption3(context, 1.0),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_getSkyStatus(index).isNotEmpty)
                            pngIcon(_getSkyStatus(index),
                                Theme.of(context).colorScheme.onBackground,
                                width: 18, height: 18),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            _getTemperatures(true, index),
                            style: index == 0
                                ? caption2(context, 0.5)
                                : caption2(context, 1.0),
                          ),
                          Text(
                            _getTemperatures(false, index),
                            style: index == 0
                                ? caption2(context, 0.5)
                                : caption2(context, 1.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  final week = ['', '월', '화', '수', '목', '금', '토', '일'];
  String _getDay(int index) {
    int idx = index - 1;
    if (index == 0) {
      return '어제';
    } else if (index == 1) {
      return '오늘';
    } else {
      DateTime dateTime = DateTime.now();
      DateTime dt = DateTime(dateTime.year, dateTime.month, dateTime.day + idx);
      return '${week[dt.weekday]}요일';
    }
  }

  String _getPrecipitation(int index) {
    if (index == 0) {
      return '';
    } else {
      final fcstValue =
          state.popList.isNotEmpty ? state.popList[index - 1].fcstValue ?? '' : '';
      if (fcstValue == '0') {
        return '';
      } else {
        return '$fcstValue%';
      }
    }
  }

  String _getSkyStatus(int index) {
    if (index > 0) {
      String fcstValue = state.skyList.isNotEmpty ? state.skyList[index - 1].fcstValue ?? '' : '';
      if (fcstValue.contains('맑')) {
        return 'sunny.png';
      } else if (fcstValue.contains('흐')) {
        return 'cloudy.png';
      } else if (fcstValue.contains('많')) {
        return 'cloudy_day.png';
      }
    }
    return '';
  }

  String _getTemperatures(bool isTmn, int index) {
    String result = '';
    if (isTmn) {
      result = '${state.tmnList[index].fcstValue ?? ''}°';
    } else {
      result = '${state.tmxList[index].fcstValue ?? ''}°';
    }
    if (result.contains('.')) {
      result = '${result.substring(0, result.length - 3)}°';
    }
    return result;
  }
}

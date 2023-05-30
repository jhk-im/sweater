import 'package:flutter/material.dart';
import 'package:sweater/viewmodel/weather_main_state.dart';

class WeeksListViewWidget extends StatelessWidget {
  WeeksListViewWidget({
    super.key,
    required this.state,
  });

  final WeatherMainState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.tmnList.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: double.infinity,
          height: 50.0,
          child: Container(
            color: Colors.redAccent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_getDay(index)),
                Text(_getPrecipitation(index)),
                Text(_getSkyStatus(index)),
                Text(_getTemperatures(true, index)),
                Text(_getTemperatures(false, index)),
              ],
            ),
          ),
        );
      },
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
      DateTime dt =
      DateTime(dateTime.year, dateTime.month, dateTime.day + idx);
      return '${week[dt.weekday]}요일';
    }
  }

  String _getPrecipitation(int index) {
    if (index == 0) {
      return '';
    } else {
      final fcstValue = state.popList[index - 1].fcstValue;
      if (fcstValue == '0') {
        return '';
      } else {
        return '$fcstValue%'; 
      }
    }
  }

  String _getSkyStatus(int index) {
    if (index > 0) {
      return state.skyList[index - 1].fcstValue ?? '';
    }
    return '';
  }

  String _getTemperatures(bool isTmn, int index) {
    String result = '';
    if (isTmn) {
      result = state.tmnList[index].fcstValue ?? '';
    } else {
      result = state.tmxList[index].fcstValue ?? '';
    }

    if (result.contains('.')) {
      result = result.substring(0, result.length - 2);
    }
     
    return result;
  }
}

/*
Icon(
Icons.water_drop,
color: Theme.of(context).colorScheme.onBackground,
),
pngIcon('sunny.png',
Theme.of(context).colorScheme.onBackground),
pngIcon('cloudy.png',
Theme.of(context).colorScheme.onBackground),
*/

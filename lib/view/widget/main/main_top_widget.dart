import 'package:flutter/material.dart';
import 'package:sweater/repository/source/remote/model/short_term.dart';
import 'package:sweater/repository/source/remote/model/weather_response.dart';
import 'package:sweater/utils/text_styles.dart';
import 'package:sweater/viewmodel/weather_main_state.dart';

class MainTopWidget extends StatefulWidget {
  const MainTopWidget({
    super.key,
    required this.state,
    required this.isScrollDown,
  });

  final WeatherMainState state;
  final bool isScrollDown;

  @override
  State<MainTopWidget> createState() => _MainTopWidgetState();
}

class _MainTopWidgetState extends State<MainTopWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 24.0,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.state.address?.region1depthName ?? '',
              style: title100(context),
            ),
            Text(
              '${widget.state.address?.region2depthName} ${widget.state.address?.region3depthName}',
              style: body(context),
            ),
            if (!widget.isScrollDown)
              Text(
                widget.state.ultraShortTerm.isNotEmpty
                    ? _getTemperatureFromUltraShortTerm(widget.state.ultraShortTerm)
                    : '',
                style: largeTitleBold(context),
              ),
            if (!widget.isScrollDown)
              Text(
                widget.state.skyList.isNotEmpty
                    ? widget.state.skyList[0].fcstValue ?? ''
                    : '',
                style: body(context),
              ),
            if (!widget.isScrollDown)
              Text(
                '${_getTemperature(widget.state.tmnList)} / ${_getTemperature(widget.state.tmxList)}',
                style: body(context),
              ),
            if (widget.isScrollDown)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  '${widget.state.todayTmpList.isNotEmpty
                      ? '${widget.state.todayTmpList[0].fcstValue ?? ''}°'
                      : ''} / ${widget.state.skyList.isNotEmpty ? widget.state.skyList[0].fcstValue ?? '' : ''}',
                  style: body(context),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getTemperature(List<WeatherItem> list) {
    if (list.isNotEmpty) {
      WeatherItem item = list[0];
      return '${item.fcstValue?.substring(0, item.fcstValue!.length - 2) ?? ''}°';
    }
    return '';
  }

  String _getTemperatureFromUltraShortTerm(List<WeatherItem> list) {
    if (list.isNotEmpty) {
      for (WeatherItem item in list) {
        if (item.category == 'T1H') {
          return '${item.obsrValue?.substring(0, item.obsrValue!.length - 2) ?? ''}°';
        }
      }
    }
    return '';
  }
}

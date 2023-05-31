import 'package:flutter/material.dart';
import 'package:sweater/repository/source/remote/model/fcst.dart';
import 'package:sweater/repository/source/remote/model/ncst.dart';
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
            if (!widget.isScrollDown)
              Text(
                widget.state.todayTmpList.isNotEmpty
                    ? '${widget.state.todayTmpList[0].fcstValue ?? ''}°'
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
                '${_getTemperatureFromFcst(widget.state.tmnList)} / ${_getTemperatureFromFcst(widget.state.tmxList)}',
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

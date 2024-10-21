import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sweater/repository/source/remote/model/weather_response.dart';
import 'package:sweater/repository/weather_repository.dart';
import 'package:sweater/viewmodel/weather_main_state.dart';

class WeatherMainViewModel with ChangeNotifier {
  final WeatherRepository _repository;

  var logger = Logger();

  var _state = const WeatherMainState();
  WeatherMainState get state => _state;

  WeatherMainViewModel(this._repository) {
    getWeatherInfo();
  }

  Future getWeatherInfo({bool isRefresh = false}) async {
    if (isRefresh) {
      _state = const WeatherMainState();
    }
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    // 현재 좌표 주소
    final getAddress = await _repository.getAddressWithCoordinate();
    _state = _state.copyWith(address: getAddress);
    double longitude = getAddress.x ?? 0;
    double latitude = getAddress.y ?? 0;
    String depth1 = getAddress.region1depthName ?? '';
    String depth2 = getAddress.region2depthName ?? '';

    final getMidCode = await _repository.getMidCode(depth1, depth2);
    getMidCode.when(success: (midCode) {
      _state = _state.copyWith(midCode: midCode);
    }, error: (e) {
      logger.e(e);
    });

    final getObservatoryWithAddress =
        await _repository.getObservatoryWithAddress(depth1, depth2);
    getObservatoryWithAddress.when(success: (observatory) {
      _state = _state.copyWith(observatory: observatory);
    }, error: (e) {
      logger.e(e);
    });

    // 출몰
    var getRiseSet =
        await _repository.getSunRiseWithCoordinate(longitude, latitude);
    getRiseSet.when(success: (riseSet) {
      _state = state.copyWith(riseSet: riseSet);
    }, error: (e) {
      logger.e(e);
    });

    // 초단기 실황
    final getUltraShortTerm =
        await _repository.getUltraShortTermLive(longitude, latitude);
    getUltraShortTerm.when(success: (ultraShortTerm) {
      _state = state.copyWith(ultraShortTerm: ultraShortTerm);
    }, error: (e) {
      logger.e(e);
    });

    // 오늘(내일, 모레) 예보
    final getTodayShortTerm =
        await _repository.getTodayShortTerm(longitude, latitude);
    getTodayShortTerm.when(success: (todayShortTerm) {
      final date = DateTime.now();
      final todayDate = date
          .toString()
          .replaceAll(RegExp("[^0-9\\s]"), "")
          .replaceAll(" ", "");
      String today = todayDate.substring(0, 8);
      int todayTime = int.parse(todayDate.substring(8, 10));
      final tomorrowDate = DateTime(date.year, date.month, date.day + 1)
          .toString()
          .replaceAll(RegExp("[^0-9\\s]"), "")
          .replaceAll(" ", "");
      String tomorrow = tomorrowDate.substring(0, 8);
      List<WeatherItem> todayList = [];
      todayList.addAll(todayShortTerm
          .where((element) =>
              int.parse(element.fcstDate!) == int.parse(today) &&
                  int.parse(element.fcstTime!.substring(0, 2)) >= todayTime ||
              int.parse(element.fcstDate!) > int.parse(today))
          .toList());
      List<WeatherItem> todayTmpList = [];
      todayTmpList.addAll(
          todayList.where((element) => element.category! == 'TMP').toList());
      List<WeatherItem> todaySkyList = [];
      todaySkyList.addAll(
          todayList.where((element) => element.category! == 'SKY').toList());
      List<WeatherItem> todayPopList = [];
      todayPopList.addAll(
          todayList.where((element) => element.category! == 'POP').toList());

      List<WeatherItem> tomorrowList = [];
      tomorrowList.addAll(todayShortTerm
          .where((element) =>
              int.parse(element.fcstDate!) == int.parse(tomorrow) &&
                  int.parse(element.fcstTime!.substring(0, 2)) >= todayTime ||
              int.parse(element.fcstDate!) > int.parse(tomorrow))
          .toList());
      List<WeatherItem> tomorrowTmpList = [];
      tomorrowTmpList.addAll(
          tomorrowList.where((element) => element.category! == 'TMP').toList());
      List<WeatherItem> tomorrowSkyList = [];
      tomorrowSkyList.addAll(
          tomorrowList.where((element) => element.category! == 'SKY').toList());
      List<WeatherItem> tomorrowPopList = [];
      tomorrowPopList.addAll(
          tomorrowList.where((element) => element.category! == 'POP').toList());

      final tmnList = state.tmnList.sublist(0);
      tmnList.addAll(todayShortTerm
          .where((element) => element.category! == 'TMN')
          .toList());
      final tmxList = state.tmxList.sublist(0);
      tmxList.addAll(todayShortTerm
          .where((element) => element.category! == 'TMX')
          .toList());
      List<WeatherItem> popList = [];
      _updatePopList(
          todayShortTerm
              .where((element) => element.category! == 'POP')
              .toList(),
          popList);
      List<WeatherItem> skyList = [];
      _updateSkyList(
          todayShortTerm
              .where((element) => element.category! == 'SKY')
              .toList(),
          skyList);
      _state = state.copyWith(
        todayTmpList: todayTmpList,
        todayPopList: todayPopList,
        todaySkyList: todaySkyList,
        tomorrowTmpList: tomorrowTmpList,
        tomorrowPopList: tomorrowPopList,
        tomorrowSkyList: tomorrowSkyList,
        tmnList: tmnList,
        tmxList: tmxList,
        popList: popList,
        skyList: skyList,
      );
    }, error: (e) {
      logger.e(e);
    });

    // 어제 예보
    final getYesterdayShortTerm =
        await _repository.getYesterdayShortTerm(longitude, latitude);
    getYesterdayShortTerm.when(success: (yesterdayShortTerm) {
      _state = state.copyWith(
          yesterdayTmpList: yesterdayShortTerm
              .where((element) => element.category! == 'TMP')
              .toList());
      _state = state.copyWith(
          yesterdaySkyList: yesterdayShortTerm
              .where((element) => element.category! == 'SKY')
              .toList());
      _state = state.copyWith(
          yesterdayPopList: yesterdayShortTerm
              .where((element) => element.category! == 'POP')
              .toList());
    }, error: (e) {
      logger.e(e);
    });

    // 중기 육상 예보
    final getMidTermLand = await _repository.getMidTermLand(depth1, depth2);
    getMidTermLand.when(success: (midTermLand) {
      final popList = state.popList.sublist(0);
      popList.add(_createWeatherItem(popList.last,
          max(midTermLand.rnSt3Am ?? 0, midTermLand.rnSt3Pm ?? 0)));
      popList.add(_createWeatherItem(popList.last,
          max(midTermLand.rnSt4Am ?? 0, midTermLand.rnSt4Pm ?? 0)));
      popList.add(_createWeatherItem(popList.last,
          max(midTermLand.rnSt5Am ?? 0, midTermLand.rnSt5Pm ?? 0)));
      popList.add(_createWeatherItem(popList.last,
          max(midTermLand.rnSt6Am ?? 0, midTermLand.rnSt6Pm ?? 0)));
      popList.add(_createWeatherItem(popList.last,
          max(midTermLand.rnSt7Am ?? 0, midTermLand.rnSt7Pm ?? 0)));
      popList.add(_createWeatherItem(popList.last, midTermLand.rnSt8 ?? 0));
      popList.add(_createWeatherItem(popList.last, midTermLand.rnSt9 ?? 0));
      popList.add(_createWeatherItem(popList.last, midTermLand.rnSt10 ?? 0));
      final skyList = state.skyList.sublist(0);
      skyList.add(_createWeatherItem(skyList.last, midTermLand.wf3Pm ?? ''));
      skyList.add(_createWeatherItem(skyList.last, midTermLand.wf4Pm ?? ''));
      skyList.add(_createWeatherItem(skyList.last, midTermLand.wf5Pm ?? ''));
      skyList.add(_createWeatherItem(skyList.last, midTermLand.wf6Pm ?? ''));
      skyList.add(_createWeatherItem(skyList.last, midTermLand.wf7Pm ?? ''));
      skyList.add(_createWeatherItem(skyList.last, midTermLand.wf8 ?? ''));
      skyList.add(_createWeatherItem(skyList.last, midTermLand.wf9 ?? ''));
      skyList.add(_createWeatherItem(skyList.last, midTermLand.wf10 ?? ''));
      _state = state.copyWith(popList: popList, skyList: skyList);
    }, error: (e) {
      logger.e(e);
    });

    // 중기 기온 예보
    var getMidTa =
        await _repository.getMidTermTemperature(_state.midCode?.code ?? '');
    getMidTa.when(success: (midTemp) {
      final tmnList = state.tmnList.sublist(0);
      tmnList.add(_createWeatherItem(tmnList.last, midTemp.taMin3 ?? 0));
      tmnList.add(_createWeatherItem(tmnList.last, midTemp.taMin4 ?? 0));
      tmnList.add(_createWeatherItem(tmnList.last, midTemp.taMin5 ?? 0));
      tmnList.add(_createWeatherItem(tmnList.last, midTemp.taMin6 ?? 0));
      tmnList.add(_createWeatherItem(tmnList.last, midTemp.taMin7 ?? 0));
      tmnList.add(_createWeatherItem(tmnList.last, midTemp.taMin8 ?? 0));
      tmnList.add(_createWeatherItem(tmnList.last, midTemp.taMin9 ?? 0));
      tmnList.add(_createWeatherItem(tmnList.last, midTemp.taMin10 ?? 0));
      final tmxList = state.tmxList.sublist(0);
      tmxList.add(_createWeatherItem(tmxList.last, midTemp.taMax3 ?? 0));
      tmxList.add(_createWeatherItem(tmxList.last, midTemp.taMax4 ?? 0));
      tmxList.add(_createWeatherItem(tmxList.last, midTemp.taMax5 ?? 0));
      tmxList.add(_createWeatherItem(tmxList.last, midTemp.taMax6 ?? 0));
      tmxList.add(_createWeatherItem(tmxList.last, midTemp.taMax7 ?? 0));
      tmxList.add(_createWeatherItem(tmxList.last, midTemp.taMax8 ?? 0));
      tmxList.add(_createWeatherItem(tmxList.last, midTemp.taMax9 ?? 0));
      tmxList.add(_createWeatherItem(tmxList.last, midTemp.taMax10 ?? 0));
      _state = state.copyWith(tmnList: tmnList, tmxList: tmxList);
    }, error: (e) {
      logger.e(e);
    });

    // 대기질
    var getFineDust = await _repository.getFineDust(depth2);
    getFineDust.when(success: (fineDustList) {
      _state = state.copyWith(fineDustList: fineDustList);
    }, error: (e) {
      logger.e(e);
    });

    // 자외선
    var getUltraviolet =
        await _repository.getUltraviolet('${_state.observatory?.code}');
    getUltraviolet.when(success: (ultraviolet) {
      _state = state.copyWith(ultraviolet: ultraviolet);
    }, error: (e) {
      logger.e(e);
    });

    _state = state.copyWith(
      isLoading: false,
    );
    notifyListeners();
  }

  void _updatePopList(List<WeatherItem> list, List<WeatherItem> updateList) {
    var startDate = '';
    for (WeatherItem item in list) {
      if (startDate == item.fcstDate) {
        if (updateList.isNotEmpty) {
          int value1 = int.parse(updateList.last.fcstValue ?? '0');
          int value2 = int.parse(item.fcstValue ?? '0');
          updateList.last.fcstValue = max(value1, value2).toString();
        }
      } else {
        updateList.add(item);
      }
      startDate = item.fcstDate ?? '';
    }
  }

  void _updateSkyList(List<WeatherItem> list, List<WeatherItem> updateList) {
    var startDate = '';
    List<String> values = [];
    for (WeatherItem item in list) {
      if (startDate == item.fcstDate) {
        if (updateList.isNotEmpty) {
          values.add(item.fcstValue ?? '');
        }
      } else {
        if (updateList.isNotEmpty) {
          String value = '3';
          int value1 = values.where((element) => element == '1').length;
          int value3 = values.where((element) => element == '3').length;
          int value4 = values.where((element) => element == '4').length;
          if (value1 > value3 && value1 > value4) {
            value = '1';
          }
          if (value4 > value3 && value4 > value1) {
            value = '4';
          }
          WeatherItem item = updateList[updateList.length - 1];
          item.fcstValue = item.weatherCategory?.codeValues?[int.parse(value)];
          values.clear();
        }
        updateList.add(item);
      }
      startDate = item.fcstDate ?? '';
    }
    WeatherItem last = updateList.last;
    last.fcstValue =
        last.weatherCategory?.codeValues?[int.parse(last.fcstValue ?? '')];
  }

  WeatherItem _createWeatherItem(WeatherItem last, value) {
    WeatherItem item = WeatherItem();
    item.category = last.category;
    item.weatherCategory = last.weatherCategory;
    item.baseTime = last.baseTime;
    item.baseDate = last.baseDate;
    item.nx = last.nx;
    item.ny = last.ny;
    item.fcstTime = last.fcstTime;
    final date = DateTime.parse(last.fcstDate ?? '');
    final newDate = DateTime(date.year, date.month, date.day + 1)
        .toString()
        .replaceAll(RegExp("[^0-9\\s]"), "")
        .replaceAll(" ", "");
    item.fcstDate = newDate.substring(0, 8);
    item.fcstValue = '$value';
    return item;
  }
}

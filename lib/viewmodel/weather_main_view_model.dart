import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sweater/repository/source/remote/model/fcst.dart';
import 'package:sweater/repository/weather_repository.dart';
import 'package:sweater/viewmodel/weather_main_state.dart';

class WeatherMainViewModel with ChangeNotifier {
  final WeatherRepository _repository;

  var _state = const WeatherMainState();
  WeatherMainState get state => _state;

  WeatherMainViewModel(this._repository) {
    _getWeatherInfo();
  }

  Future _getWeatherInfo() async {
    _state = state.copyWith(
      isLoading: true,
    );
    notifyListeners();

    // 현재 좌표 주소
    var getAddress = await _repository.getAddressWithCoordinate();
    getAddress.when(success: (address) async {
      print(address);
      _state = state.copyWith(address: address);

      String depth1 = address.region1depthName ?? '';
      String depth2 = address.region2depthName ?? '';

      // 중기 예보 지점 코드
      var getMidCode = await _repository.getMidCode(depth1, depth2);
      getMidCode.when(success: (midCode) {
        print(midCode);
        _state = state.copyWith(midCode: midCode);
      }, error: (e) {
        print(e);
        _state = state.copyWith(
          errorNum: 3,
        );
        notifyListeners();
      });

      // 관측소 정보
      var getObservatory =
          await _repository.getObservatoryWithAddress(depth1, depth2);
      getObservatory.when(success: (observatory) async {
        print(observatory);
        _state = state.copyWith(observatory: observatory);
      }, error: (e) {
        print(e);
        _state = state.copyWith(
          errorNum: 4,
        );
        notifyListeners();
      });

      getWeatherInfo();
    }, error: (e) {
      print(e);
      _state = state.copyWith(
        errorNum: 1,
      );
      notifyListeners();
    });
  }

  Future getWeatherInfo() async {
    double longitude = state.address?.x ?? 0;
    double latitude = state.address?.y ?? 0;
    String depth1 = state.address?.region1depthName ?? '';
    String depth2 = state.address?.region2depthName ?? '';
    String regId = state.midCode?.code ?? '';

    // 날씨 현재 실황
    // 강수형태, 습도, 강수량, 기온, 풍속, 풍속(동서), 풍속(남북), 풍향
    var ultraNcst = await _repository.getUltraStrNcst(longitude, latitude);
    ultraNcst.when(success: (ncstList) {
      _state = state.copyWith(ncstList: ncstList);
    }, error: (e) {
      print(e);
      _state = state.copyWith(
        errorNum: 2,
      );
      notifyListeners();
    });

    // 어제 단기 예보
    // 어제 - 오늘 : 최저 최고
    // 0200
    var yesterdayGetVilageFcst =
        await _repository.getVilageFast(false, longitude, latitude);
    yesterdayGetVilageFcst.when(success: (yesterdayFcstList) {
      //print('Yesterday Fcst list length -> ${info.length}');
      List<Fcst> tmnList = [];
      tmnList.addAll(yesterdayFcstList
          .where((element) => element.category! == 'TMN')
          .toList());
      List<Fcst> tmxList = [];
      tmxList.addAll(yesterdayFcstList
          .where((element) => element.category! == 'TMX')
          .toList());
      _state = state.copyWith(tmnList: tmnList, tmxList: tmxList);
    }, error: (e) {
      print(e);
      _state = state.copyWith(
        errorNum: 3,
      );
      notifyListeners();
    });

    // 오늘 단기 예보
    // 오늘 - 내일 : 최저 최고 기온
    var tomorrowGetVilageFcst =
        await _repository.getVilageFast(true, longitude, latitude);
    tomorrowGetVilageFcst.when(success: (tomorrowFcstList) {
      //print('Tomorrow Fcst list length -> ${info.length}');
      final tmnList = state.tmnList.sublist(0);
      tmnList.addAll(tomorrowFcstList
          .where((element) => element.category! == 'TMN')
          .toList());
      final tmxList = state.tmxList.sublist(0);
      tmxList.addAll(tomorrowFcstList
          .where((element) => element.category! == 'TMX')
          .toList());
      List<Fcst> popList = [];
      _updatePopList(
          tomorrowFcstList
              .where((element) => element.category! == 'POP')
              .toList(),
          popList);
      List<Fcst> skyList = [];
      print(skyList);
      _updateSkyList(
          tomorrowFcstList
              .where((element) => element.category! == 'SKY')
              .toList(),
          skyList);
      _state = state.copyWith(
          tmnList: tmnList,
          tmxList: tmxList,
          popList: popList,
          skyList: skyList);
    }, error: (e) {
      print(e);
      _state = state.copyWith(
        errorNum: 3,
      );
      notifyListeners();
    });

    // 중기 기상 정보를 위한 코드 가져오기
    // 중기 예보 * 3일후 - 10일 후 까지
    // 강수확률 평균, 하늘상태, 최고 최저 기온
    // 중기 기온 예보
    var getMidTa = await _repository.getMidTa(regId);
    getMidTa.when(success: (midTa) {
      //print(info);
      final tmnList = state.tmnList.sublist(0);
      tmnList.add(_createFcst(tmnList.last, midTa.taMin3 ?? 0));
      tmnList.add(_createFcst(tmnList.last, midTa.taMin4 ?? 0));
      tmnList.add(_createFcst(tmnList.last, midTa.taMin5 ?? 0));
      tmnList.add(_createFcst(tmnList.last, midTa.taMin6 ?? 0));
      tmnList.add(_createFcst(tmnList.last, midTa.taMin7 ?? 0));
      tmnList.add(_createFcst(tmnList.last, midTa.taMin8 ?? 0));
      tmnList.add(_createFcst(tmnList.last, midTa.taMin9 ?? 0));
      tmnList.add(_createFcst(tmnList.last, midTa.taMin10 ?? 0));
      final tmxList = state.tmxList.sublist(0);
      tmxList.add(_createFcst(tmxList.last, midTa.taMax3 ?? 0));
      tmxList.add(_createFcst(tmxList.last, midTa.taMax4 ?? 0));
      tmxList.add(_createFcst(tmxList.last, midTa.taMax5 ?? 0));
      tmxList.add(_createFcst(tmxList.last, midTa.taMax6 ?? 0));
      tmxList.add(_createFcst(tmxList.last, midTa.taMax7 ?? 0));
      tmxList.add(_createFcst(tmxList.last, midTa.taMax8 ?? 0));
      tmxList.add(_createFcst(tmxList.last, midTa.taMax9 ?? 0));
      tmxList.add(_createFcst(tmxList.last, midTa.taMax10 ?? 0));
      _state = state.copyWith(tmnList: tmnList, tmxList: tmxList);
    }, error: (e) {
      print(e);
      _state = state.copyWith(
        errorNum: 3,
      );
      notifyListeners();
    });

    // 중기 육상 예보
    var getMidLandFcst = await _repository.getMidLandFcst(depth1, depth2);
    getMidLandFcst.when(success: (midLandFcst) {
      final popList = state.popList.sublist(0);
      popList.add(_createFcst(popList.last,
          max(midLandFcst.rnSt3Am ?? 0, midLandFcst.rnSt3Pm ?? 0)));
      popList.add(_createFcst(popList.last,
          max(midLandFcst.rnSt4Am ?? 0, midLandFcst.rnSt4Pm ?? 0)));
      popList.add(_createFcst(popList.last,
          max(midLandFcst.rnSt5Am ?? 0, midLandFcst.rnSt5Pm ?? 0)));
      popList.add(_createFcst(popList.last,
          max(midLandFcst.rnSt6Am ?? 0, midLandFcst.rnSt6Pm ?? 0)));
      popList.add(_createFcst(popList.last,
          max(midLandFcst.rnSt7Am ?? 0, midLandFcst.rnSt7Pm ?? 0)));
      popList.add(_createFcst(popList.last, midLandFcst.rnSt8 ?? 0));
      popList.add(_createFcst(popList.last, midLandFcst.rnSt9 ?? 0));
      popList.add(_createFcst(popList.last, midLandFcst.rnSt10 ?? 0));
      final skyList = state.skyList.sublist(0);
      skyList.add(_createFcst(skyList.last, midLandFcst.wf3Pm ?? ''));
      skyList.add(_createFcst(skyList.last, midLandFcst.wf4Pm ?? ''));
      skyList.add(_createFcst(skyList.last, midLandFcst.wf5Pm ?? ''));
      skyList.add(_createFcst(skyList.last, midLandFcst.wf6Pm ?? ''));
      skyList.add(_createFcst(skyList.last, midLandFcst.wf7Pm ?? ''));
      skyList.add(_createFcst(skyList.last, midLandFcst.wf8 ?? ''));
      skyList.add(_createFcst(skyList.last, midLandFcst.wf9 ?? ''));
      skyList.add(_createFcst(skyList.last, midLandFcst.wf10 ?? ''));
      _state = state.copyWith(popList: popList, skyList: skyList);
    }, error: (e) {
      print(e);
      _state = state.copyWith(
        errorNum: 3,
      );
      notifyListeners();
    });
    print('---날씨 실황---');
    print(state.ncstList);
    print('---최저기온---');
    print(state.tmnList);
    print('---최고기온---');
    print(state.tmxList);
    print('---강수량---');
    print(state.popList);
    print('---하늘상태---');
    print(state.skyList);
    getLifeIndex();
  }

  Future getLifeIndex() async {
    double longitude = state.address?.x ?? 0;
    double latitude = state.address?.y ?? 0;
    String depth2 = state.address?.region2depthName ?? '';
    String uvCode = '${state.observatory?.code}';

    // 미세먼지
    var getMesureDnsty = await _repository.getMesureDnsty(false, depth2);
    getMesureDnsty.when(success: (dnstyList) {
      print('---미세먼지---');
      print(dnstyList);
      _state = state.copyWith(dnstyList: dnstyList);
    }, error: (e) {
      print(e);
      _state = state.copyWith(
        errorNum: 4,
      );
      notifyListeners();
    });

    // 출몰
    var getRiseSet =
        await _repository.getRiseSetWithCoordinate(longitude, latitude);
    getRiseSet.when(success: (riseSet) {
      print('---일출/일몰---');
      print(riseSet);
      _state = state.copyWith(riseSet: riseSet);
    }, error: (e) {
      print(e);
      _state = state.copyWith(
        errorNum: 5,
      );
      notifyListeners();
    });

    // 관측소 정보 -> 자외선 치수
    //print(info);
    // 자외선 지수
    var getUVRays = await _repository.getUVRays(uvCode);
    getUVRays.when(success: (uvRays) {
      print('---자외선 지수---');
      print(uvRays);
      _state = state.copyWith(uvRays: uvRays);
    }, error: (e) {
      print(e);
      _state = state.copyWith(
        errorNum: 6,
      );
      notifyListeners();
    });

    _state = state.copyWith(
      isLoading: false,
    );
    notifyListeners();
  }

  void _updatePopList(List<Fcst> list, List<Fcst> updateList) {
    var startDate = '';
    for (Fcst fcst in list) {
      if (startDate == fcst.fcstDate) {
        if (updateList.isNotEmpty) {
          int value1 = int.parse(updateList.last.fcstValue ?? '0');
          int value2 = int.parse(fcst.fcstValue ?? '0');
          updateList.last.fcstValue = max(value1, value2).toString();
        }
      } else {
        updateList.add(fcst);
      }
      startDate = fcst.fcstDate ?? '';
    }
  }

  void _updateSkyList(List<Fcst> list, List<Fcst> updateList) {
    var startDate = '';
    List<String> values = [];
    for (Fcst fcst in list) {
      if (startDate == fcst.fcstDate) {
        if (updateList.isNotEmpty) {
          values.add(fcst.fcstValue ?? '');
        }
      } else {
        if (updateList.isNotEmpty) {
          String value = '3';
          int value1 = values.where((element) => element == '1').length;
          int value3 = values.where((element) => element == '3').length;
          int value4 = values.where((element) => element == '4').length;
          //print('$value1, $value3, $value4');
          if (value1 > value3 && value1 > value4) {
            value = '1';
          }
          if (value4 > value3 && value4 > value1) {
            value = '4';
          }
          Fcst updateFcst = updateList[updateList.length - 1];
          updateFcst.fcstValue =
              fcst.weatherCategory?.codeValues?[int.parse(value)];
          print(updateFcst);
          values.clear();
        }
        updateList.add(fcst);
      }
      startDate = fcst.fcstDate ?? '';
    }
    Fcst last = updateList.last;
    last.fcstValue = last.weatherCategory?.codeValues?[int.parse(last.fcstValue ?? '')];
  }

  Fcst _createFcst(Fcst last, value) {
    Fcst fcst = Fcst();
    fcst.category = last.category;
    fcst.weatherCategory = last.weatherCategory;
    fcst.baseTime = last.baseTime;
    fcst.baseDate = last.baseDate;
    fcst.nx = last.nx;
    fcst.ny = last.ny;
    fcst.fcstTime = last.fcstTime;
    final date = DateTime.parse(last.fcstDate ?? '');
    final newDate = DateTime(date.year, date.month, date.day + 1)
        .toString()
        .replaceAll(RegExp("[^0-9\\s]"), "")
        .replaceAll(" ", "");
    fcst.fcstDate = newDate.substring(0, 8);
    fcst.fcstValue = '$value';
    return fcst;
  }
}

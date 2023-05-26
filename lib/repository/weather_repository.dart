import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweater/repository/source/csv/mid_code_parser.dart';
import 'package:sweater/repository/source/csv/observatory_parser.dart';
import 'package:sweater/repository/source/remote/model/address.dart';
import 'package:sweater/repository/source/remote/model/dnsty.dart';
import 'package:sweater/repository/source/remote/model/fcst.dart';
import 'package:sweater/repository/source/remote/model/mid_code.dart';
import 'package:sweater/repository/source/remote/model/mid_land_fcst.dart';
import 'package:sweater/repository/source/remote/model/mid_ta.dart';
import 'package:sweater/repository/source/remote/model/ncst.dart';
import 'package:sweater/repository/source/remote/model/observatory.dart';
import 'package:sweater/repository/source/remote/model/rise_set.dart';
import 'package:sweater/repository/source/remote/model/uv_rays.dart';
import 'package:sweater/repository/source/remote/model/weather_category.dart';
import 'package:sweater/repository/source/mapper/weather_mapper.dart';
import 'package:sweater/repository/source/local/weather_dao.dart';
import 'package:sweater/repository/location_repository.dart';
import 'package:sweater/repository/source/remote/remote_api.dart';
import 'package:sweater/utils/convert_gps.dart';
import 'package:sweater/utils/result.dart';
import 'package:xml/xml.dart';
import 'package:xml2json/xml2json.dart';

class WeatherRepository {
  final RemoteApi _api;
  final WeatherDao _dao;
  final _observatoryParser = ObservatoryParser();
  final _midCodeParser = MidCodeParser();
  final List<String> baseTimeList = [
    '2300',
    '2300',
    '2300',
    '0200',
    '0200',
    '0200',
    '0500',
    '0500',
    '0500',
    '0800',
    '0800',
    '0800',
    '1100',
    '1100',
    '1100',
    '1400',
    '1400',
    '1400',
    '1700',
    '1700',
    '1700',
    '2000',
    '2000',
    '2000',
  ];
  final Map<String, String> midFcstCode = {
    '서울특별시, 인천광역시, 경기도': '11B00000',
    '고성, 속초, 양양, 강릉, 동해, 삼척, 태백': '11D10000',
    '강원도, 철원, 화천, 춘천, 양구, 인제, 홍천, 횡성, 평창, 정선, 영월': '11D20000',
    '대전광역시, 세종특별자치시, 충청남도': '11C20000',
    '충청북도': '11C10000',
    '광주광역시, 전라남도': '11F20000',
    '전라북도': '11F10000',
    '대구광역시, 경상북도': '11H10000',
    '부산광역시, 울산광역시 경상남도': '11H20000',
    '제주도': '11G00000',
  };
  String _getMidFcstRegId(String depth1, String depth2) {
    String regId = '11B00000';
    for (String key in midFcstCode.keys) {
      if (depth1 == '강원도' && depth2.isNotEmpty) {
        if (key.contains(depth2.substring(0, 2))) {
          regId = midFcstCode[key]!;
          break;
        }
      } else {
        if (key.contains(depth1)) {
          regId = midFcstCode[key]!;
          break;
        }
      }
    }
    return regId;
  }

  String _getMidDate() {
    String date = '';
    // 30분전
    DateTime dateTime = DateTime.now();
    String dt = DateTime(dateTime.year, dateTime.month, dateTime.day,
            dateTime.hour, dateTime.minute - 30)
        .toString()
        .replaceAll(RegExp("[^0-9\\s]"), "")
        .replaceAll(" ", "");
    String current = dt.substring(0, 8);
    int currentTime = int.parse(dt.substring(8, 10));
    String prevDt = DateTime(dateTime.year, dateTime.month, dateTime.day - 1)
        .toString()
        .replaceAll(RegExp("[^0-9\\s]"), "")
        .replaceAll(" ", "");
    String prev = prevDt.substring(0, 8);
    if (currentTime < 6 || currentTime > 18) {
      date = '${prev}1800';
    } else if (currentTime > 6 && currentTime < 18) {
      date = '${current}0600';
    } else {
      date = '${current}1800';
    }
    return date;
  }

  LocationRepository locationRepository = LocationRepository();

  WeatherRepository(this._api, this._dao);

  // 현재 좌표 주소 조회
  Future<Result<Address>> getAddressWithCoordinate() async {
    final localList = await _dao.getAllAddressList();
    Position position = await locationRepository.getLocation();

    // 로컬에 있고 좌표값 변경이 없는 경우 로컬 리턴
    if (localList.isNotEmpty) {
      print('getAddressWithCoordinate() -> local return');
      return Result.success(localList[0].toAddress());
    }

    // 카카오 주소 검색
    try {
      final response = await _api.getAddressWithCoordinate(
          position.longitude, position.latitude);
      final jsonResult = jsonDecode(response.body);
      AddressList result = AddressList.fromJson(jsonResult);
      Address address = Address();
      if (result.documents != null) {
        address = result.documents![0];
        _dao.clearAddress();
        _dao.insertAddress(address.toAddressEntity());
      }
      print('getAddressWithCoordinate() -> api return');
      return Result.success(address);
    } catch (e) {
      return Result.error(
          Exception('getAddressWithCoordinate failed: ${e.toString()}'));
    }
  }

  // 관측소 정보 조회
  Future<Result<Observatory>> getObservatoryWithAddress(
      String depth1, String depth2) async {
    final localList = await _dao.getAllObservatoryList();
    List<Observatory> list = [];
    Observatory result = Observatory();
    if (localList.isNotEmpty) {
      print('getObservatoryWithAddress() -> local return');
      list = localList.map((e) => e.toObservatory()).toList();
    } else {
      print('getObservatoryWithAddress() -> csv return');
      var csv = await rootBundle.loadString(
        "assets/data/observatory.csv",
      );
      list = await _observatoryParser.parse(csv);
      _dao.clearObservatory();
      _dao.insertObservatoryList(
          list.map((e) => e.toObservatoryEntity()).toList());
    }

    var d1 = list.where((e) => e.depth1 == depth1 && e.depth2 == depth2);
    if (d1.isNotEmpty) {
      result = d1.toList()[0];
    } else {
      var d2 = list.where((e) => e.depth1 == depth1 && e.depth2 == '');
      if (d2.isNotEmpty) {
        result = d2.toList()[0];
      } else {
        var d3 = list.where((e) => e.depth1 == '서울특별시');
        if (d3.isNotEmpty) {
          result = d3.toList()[0];
        }
      }
    }

    if (result.depth1 != null) {
      return Result.success(result);
    } else {
      return Result.error(
          Exception('getObservatoryWithAddress failed: not found'));
    }
  }

  // 자외선 지수 조회
  Future<Result<UVRays>> getUVRays(String areaNo) async {
    final localList = await _dao.getAllUVRaysList();

    // 현재시간
    String dt = DateTime.now()
        .toString()
        .replaceAll(RegExp("[^0-9\\s]"), "")
        .replaceAll(" ", "");
    String time = dt.substring(0, 10);

    if (localList.isNotEmpty) {
      if (localList[0].date == time) {
        print('getUVRays() -> local return');
        return Result.success(localList[0].toUVRays());
      }
    }

    // remote
    UVRays result = UVRays();
    try {
      final response = await _api.getUVRays(time, areaNo);
      final jsonResult = jsonDecode(response.body);
      UVRaysList list = UVRaysList.fromJson(jsonResult['response']['body']);
      if (list.items != null) {
        if (list.items!.item != null) {
          result = list.items!.item![0];
          // 로컬 업데이트
          if (result.code != null) {
            _dao.clearUVRaysList();
            for (UVRays uv in list.items!.item!) {
              uv.date = time;
            }
            _dao.insertUVRaysList(
                list.items!.item!.map((e) => e.toUVRaysEntity()).toList());
          }
        }
      }
      print('getUVRays() -> api return');
    } catch (e) {
      return Result.error(Exception('getUVRays failed: ${e.toString()}'));
    }

    if (result.code != null) {
      return Result.success(result);
    } else {
      return Result.error(Exception('getUVRays failed: not found'));
    }
  }

  // 좌표 출몰 조회
  Future<Result<RiseSet>> getRiseSetWithCoordinate(
      double longitude, double latitude) async {
    final localList = await _dao.getAllRiseSet();
    String dateTime = DateTime.now()
        .toString()
        .replaceAll(RegExp("[^0-9\\s]"), "")
        .replaceAll(" ", "");
    String currentDate = dateTime.toString().substring(0, 8);

    // 로컬에 있고 날짜가 변경되지 않은 경우
    if (localList.isNotEmpty && currentDate == localList[0].locdate) {
      print('getRiseSetWithCoordinate() -> local return');
      return Result.success(localList[0].toRiseSet());
    }

    // remote
    try {
      final response = await _api.getRiseSetInfoWithCoordinate(
          currentDate, longitude, latitude);

      final xmlResult = XmlDocument.parse(utf8.decode(response.bodyBytes))
          .findAllElements('item');

      final jsonTransformer = Xml2Json();
      jsonTransformer.parse(xmlResult.toString());
      var json = jsonDecode(jsonTransformer.toParker());

      RiseSet result = RiseSet.fromJson(json['item']);

      // 로컬 업데이트
      if (result.locdate != null) {
        _dao.clearRiseSet();
        _dao.insertRiseInfo(result.toRiseSetEntity());
      }
      print('getRiseSetWithCoordinate() -> api return');
      return Result.success(result);
    } catch (e) {
      return Result.error(
          Exception('getRiseSetWithCoordinate failed: ${e.toString()}'));
    }
  }

  // 측정소별 미세먼지 조회
  Future<Result<List<Dnsty>>> getMesureDnsty(
      bool isRemote, String query) async {
    final localList = await _dao.getAllMesureDnstyList();

    // local
    if (!isRemote && localList.isNotEmpty) {
      if (localList[0].dataTime != null) {
        // 30분 전
        DateTime dateTime = DateTime.now();
        String dt = DateTime(dateTime.year, dateTime.month, dateTime.day,
                dateTime.hour, dateTime.minute - 30)
            .toString()
            .replaceAll(RegExp("[^0-9\\s]"), "")
            .replaceAll(" ", "");
        String currentDate = dt.substring(0, 8);
        String dataTime = localList[0].dataTime!;
        String prevDate = dataTime.substring(0, 10).replaceAll("-", "");
        String currentTime = dt.substring(8, 10);
        String prevTime =
            dataTime.substring(dataTime.length - 5, dataTime.length - 3);

        if (currentDate == prevDate && currentTime == prevTime) {
          print('getMesureDnsty() -> local return');
          return Result.success(localList.map((e) => e.toDnsty()).toList());
        }
      }
    }

    // remote
    try {
      final response = await _api.getMsrstnAcctoRltmMesureDnsty(query);
      final jsonResult = jsonDecode(response.body);
      DnstyList list = DnstyList.fromJson(jsonResult['response']['body']);
      List<Dnsty> result = [];
      if (list.items != null) {
        for (var item in list.items!) {
          result.add(item);
        }
      }
      // 로컬 업데이트
      if (result.isNotEmpty) {
        _dao.clearMesureDnstyList();
        _dao.insertMesureDnstyList(
            result.map((e) => e.toDnstyEntity()).toList());
      }
      print('getMesureDnsty() -> api return');
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('getMesureDnsty failed: ${e.toString()}'));
    }
  }

  // 중기 지역별 코드 조회
  Future<Result<MidCode>> getMidCode(String depth1, String depth2) async {
    final localList = await _dao.getAllMidCodeList();
    List<MidCode> list = [];
    MidCode result = MidCode();
    if (localList.isNotEmpty) {
      print('getMidCode() -> local return');
      list = localList.map((e) => e.toMidCode()).toList();
    } else {
      print('getMidCode() -> csv return');
      var csv = await rootBundle.loadString(
        "assets/data/mid_code.csv",
      );
      list = await _midCodeParser.parse(csv);
      _dao.clearMidCodeList();
      _dao.insertMidCodeList(list.map((e) => e.toMidCodeEntity()).toList());
    }

    var d1 = list.where((e) => e.city == depth2);
    if (d1.isNotEmpty) {
      result = d1.toList()[0];
    } else {
      var d2 = list.where((e) => e.city == depth1);
      if (d2.isNotEmpty) {
        result = d2.toList()[0];
      } else {
        var d3 = list.where((e) => e.city == '서울특별시');
        if (d3.isNotEmpty) {
          result = d3.toList()[0];
        }
      }
    }

    if (result.city != null) {
      return Result.success(result);
    } else {
      return Result.error(Exception('getMidCode failed: not found'));
    }
  }

  // 중기 기온 예보
  Future<Result<MidTa>> getMidTa(String regId) async {
    final localList = await _dao.getAllMidTaList();
    MidTa result = MidTa();
    String tmFc = _getMidDate();

    if (localList.isNotEmpty) {
      if (tmFc == localList[0].date) {
        print('getMidTa() -> local return');
        result = localList[0].toMidTa();
      }
    } else {
      // remote
      try {
        final response = await _api.getMidTa(tmFc, regId);
        final jsonResult = jsonDecode(response.body);
        MidTaList list = MidTaList.fromJson(jsonResult['response']['body']);

        if (list.items?.item != null) {
          for (var item in list.items!.item!) {
            item.date = tmFc;
            result = item;
          }
        }
        // 로컬 업데이트
        if (result.regId != null) {
          _dao.clearMidTaList();
          _dao.insertMidTa(result.toMidTaEntity());
        }
        print('getMidTa() -> api return');
      } catch (e) {
        return Result.error(Exception('getMidTa failed: ${e.toString()}'));
      }
    }

    if (result.regId != null) {
      return Result.success(result);
    } else {
      return Result.error(Exception('getMidTa failed: not found'));
    }
  }

  // 중기 육상 예보
  Future<Result<MidLandFcst>> getMidLandFcst(
      String depth1, String depth2) async {

    final localList = await _dao.getAllMidLandFcstList();
    String tmFc = _getMidDate();
    String regId = _getMidFcstRegId(depth1, depth2);
    MidLandFcst result = MidLandFcst();

    if (localList.isNotEmpty) {
      if (tmFc == localList[0].date) {
        print('getMidLandFcst() -> local return');
        result = localList[0].toMidLandFcst();
      }
    } else {
      // remote
      try {
        final response = await _api.getMidLandFcst(tmFc, regId);
        final jsonResult = jsonDecode(response.body);
        MidLandFcstList list =
        MidLandFcstList.fromJson(jsonResult['response']['body']);

        if (list.items?.item != null) {
          for (var item in list.items!.item!) {
            item.date = tmFc;
            result = item;
          }
        }
        // local update
        if (result.regId != null) {
          _dao.clearMidLandFcstList();
          _dao.insertMidLandFcst(result.toMidLandFcstEntity());
        }
        print('getMidLandFcst() -> api return');
      } catch (e) {
        return Result.error(Exception('getMidLandFcst failed: ${e.toString()}'));
      }
    }

    if (result.regId != null) {
      return Result.success(result);
    } else {
      return Result.error(Exception('getMidLandFcst failed: not found'));
    }
  }

  // 단기 예보
  Future<Result<List<Fcst>>> getVilageFast(bool isRemote) async {
    final localList = await _dao.getAllVillageFcstList();

    // 30분 전
    DateTime dateTime = DateTime.now();
    String dt = DateTime(dateTime.year, dateTime.month, dateTime.day,
            dateTime.hour, dateTime.minute - 30)
        .toString()
        .replaceAll(RegExp("[^0-9\\s]"), "")
        .replaceAll(" ", "");
    String date = dt.substring(0, 8);
    String checkTime = dt.substring(8, 10);
    int checkTimeIndex = int.parse(checkTime);
    String time = baseTimeList[checkTimeIndex];

    // local
    if (!isRemote && localList.isNotEmpty) {
      if (localList[0].baseTime != null) {
        String localTime = localList[0].baseTime!.substring(0, 2);
        String callTime = time.substring(0, 2);
        String localDate = localList[0].baseDate ?? '';
        if (date == localDate) {
          if (callTime == localTime) {
            print('getVilageFast() -> local return');
            return Result.success(localList.map((e) => e.toFcst()).toList());
          }
        }
      }
    }

    // get location
    Position position = await locationRepository.getLocation();
    var gpsToData = ConvertGps.gpsToGRID(position.latitude, position.longitude);
    int x = gpsToData['x'];
    int y = gpsToData['y'];

    // remote
    try {
      final response = await _api.getVilageFcst(date, time, x, y);
      final jsonResult = jsonDecode(response.body);
      FcstList list = FcstList.fromJson(jsonResult['response']['body']);
      List<Fcst> result = [];
      if (list.items?.item != null) {
        for (var item in list.items!.item!) {
          item.weatherCategory = await getWeatherCode(item.category ?? '');
          result.add(item);
        }
      }
      // local update
      if (result.isNotEmpty) {
        _dao.clearVilageFcstList();
        _dao.insertVilageFcstList(result.map((e) => e.toFcstEntity()).toList());
      }
      print('getVilageFast() -> api return');
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('getVilageFast failed: ${e.toString()}'));
    }
  }

  // 날씨 category 에 따른 정보 가져오기
  Future<WeatherCategory> getWeatherCode(String category) async {
    final jsonString = await rootBundle.loadString('assets/data/code.json');
    final jsonObject = jsonDecode(jsonString);
    return WeatherCategory.fromJson(jsonObject[category]);
  }

  // 초단기 실황
  Future<Result<List<Ncst>>> getUltraStrNcst(bool isRemote) async {
    final localList = await _dao.getAllUltraNcstList();

    // 30분 전
    DateTime dateTime = DateTime.now();
    String dt = DateTime(dateTime.year, dateTime.month, dateTime.day,
            dateTime.hour, dateTime.minute - 30)
        .toString()
        .replaceAll(RegExp("[^0-9\\s]"), "")
        .replaceAll(" ", "");
    String date = dt.substring(0, 8);
    String time = dt.substring(8, 12);
    String checkTime = dt.substring(8, 10);

    // local
    if (!isRemote && localList.isNotEmpty) {
      if (localList[0].baseTime != null) {
        String localTime = localList[0].baseTime!.substring(0, 2);
        String localDate = localList[0].baseDate ?? '';
        if (date == localDate) {
          if (checkTime == localTime) {
            print('getUltraStrNcst() -> local return');
            return Result.success(localList.map((e) => e.toNcst()).toList());
          }
        }
      }
    }

    // get location
    Position position = await locationRepository.getLocation();
    var gpsToData = ConvertGps.gpsToGRID(position.latitude, position.longitude);
    int x = gpsToData['x'];
    int y = gpsToData['y'];
    //print(gpsToData);

    // remote
    try {
      final response = await _api.getUltraStrNcst(date, time, x, y);
      final jsonResult = jsonDecode(response.body);
      NcstList list = NcstList.fromJson(jsonResult['response']['body']);
      List<Ncst> result = [];
      if (list.items?.item != null) {
        for (var item in list.items!.item!) {
          item.weatherCategory = await getWeatherCode(item.category ?? '');
          result.add(item);
        }
      }
      // local update
      if (result.isNotEmpty) {
        _dao.clearUltraNcstList();
        _dao.insertUltraNcstList(result.map((e) => e.toNcstEntity()).toList());
      }
      print('getUltraStrNcst() -> api return');
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('getUltraStrNcst failed: ${e.toString()}'));
    }
  }

  // 초단기 예보
  Future<Result<List<Fcst>>> getUltraStrFcst(bool isRemote) async {
    final localList = await _dao.getAllUltraFcstList();

    // 45분 전
    DateTime dateTime = DateTime.now();
    String dt = DateTime(dateTime.year, dateTime.month, dateTime.day,
            dateTime.hour, dateTime.minute - 45)
        .toString()
        .replaceAll(RegExp("[^0-9\\s]"), "")
        .replaceAll(" ", "");
    String date = dt.substring(0, 8);
    String time = dt.substring(8, 12);
    String checkTime = dt.substring(8, 10);

    // local
    if (!isRemote && localList.isNotEmpty) {
      if (localList[0].baseTime != null) {
        String localTime = localList[0].baseTime!.substring(0, 2);
        String localDate = localList[0].baseDate ?? '';
        if (date == localDate) {
          if (checkTime == localTime) {
            print('getUltraStrFcst() -> local return');
            return Result.success(localList.map((e) => e.toFcst()).toList());
          }
        }
      }
    }

    // get location
    Position position = await locationRepository.getLocation();
    var gpsToData = ConvertGps.gpsToGRID(position.latitude, position.longitude);
    int x = gpsToData['x'];
    int y = gpsToData['y'];

    // remote
    try {
      final response = await _api.getUltraStrFcst(date, time, x, y);
      final jsonResult = jsonDecode(response.body);
      FcstList list = FcstList.fromJson(jsonResult['response']['body']);
      List<Fcst> result = [];
      if (list.items?.item != null) {
        for (var item in list.items!.item!) {
          item.weatherCategory = await getWeatherCode(item.category ?? '');
          result.add(item);
        }
      }
      // local update
      if (result.isNotEmpty) {
        _dao.clearUltraFcstList();
        _dao.insertUltraFcstList(result.map((e) => e.toFcstEntity()).toList());
      }
      print('getUltraStrFcst() -> api return');
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('getUltraStrFcst failed: ${e.toString()}'));
    }
  }
}

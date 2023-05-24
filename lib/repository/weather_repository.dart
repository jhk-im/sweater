import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweater/repository/source/csv/observatory_parser.dart';
import 'package:sweater/repository/source/remote/dto/observatory_dto.dart';
import 'package:sweater/repository/source/remote/model/address.dart';
import 'package:sweater/repository/source/remote/model/adress_list.dart';
import 'package:sweater/repository/source/remote/model/dnsty.dart';
import 'package:sweater/repository/source/remote/model/dnsty_list.dart';
import 'package:sweater/repository/source/remote/model/fcst.dart';
import 'package:sweater/repository/source/remote/model/fcst_list.dart';
import 'package:sweater/repository/source/remote/model/ncst.dart';
import 'package:sweater/repository/source/remote/model/ncst_list.dart';
import 'package:sweater/repository/source/remote/model/observatory.dart';
import 'package:sweater/repository/source/remote/model/rise_set.dart';
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

  final _observatoryParser = ObservatoryParser();

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

  // 현재 좌표 출몰 조회
  Future<Result<RiseSet>> getRiseSetWithCoordinate() async {
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

    Position position = await locationRepository.getLocation();

    // remote
    try {
      final response = await _api.getRiseSetInfoWithCoordinate(
          currentDate, position.longitude, position.latitude);

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

  // 측정소별 미세먼지
  Future<Result<List<Dnsty>>> getMesureDnsty(bool isRemote) async {
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

    final address = await _dao.getAllAddressList();
    String query =
        address[0].region2depthName != null ? address[0].region2depthName! : '';

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

  Future<List<Observatory>> getObservatory() async {
    var csv = await rootBundle.loadString(
      "assets/data/observatory_data.csv",
    );
    return await _observatoryParser.parse(csv);
  }
}

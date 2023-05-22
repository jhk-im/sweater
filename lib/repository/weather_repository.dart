import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweater/model/address.dart';
import 'package:sweater/model/adress_list.dart';
import 'package:sweater/model/dnsty.dart';
import 'package:sweater/model/dnsty_list.dart';
import 'package:sweater/model/fcst.dart';
import 'package:sweater/model/fcst_list.dart';
import 'package:sweater/model/ncst.dart';
import 'package:sweater/model/ncst_list.dart';
import 'package:sweater/model/weather_category.dart';
import 'package:sweater/repository/mapper/weather_mapper.dart';
import 'package:sweater/repository/source/local/weather_dao.dart';
import 'package:sweater/repository/source/location_repository.dart';
import 'package:sweater/repository/source/remote/remote_api.dart';
import 'package:sweater/utils/convert_gps.dart';
import 'package:sweater/utils/result.dart';

class WeatherRepository {
  final RemoteApi _api;
  final WeatherDao _dao;

  LocationRepository locationRepository = LocationRepository();

  WeatherRepository(this._api, this._dao);

  // 현재 좌표 주소 검색
  Future<Result<Address>> getAddressWithCoordinate() async {
    final localList = await _dao.getAllAddressList();
    Position position = await locationRepository.getLocation();

    // 로컬에 있고 좌표값 변경이 없는 경우 로컬 리턴
    if (localList.isNotEmpty) {
      if (localList[0].x == position.longitude &&
          localList[0].y == position.latitude) {
        return Result.success(localList[0].toAddress());
      }
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
        _dao.insertAddressList(address.toAddressEntity());
      }
      return Result.success(address);
    } catch (e) {
      return Result.error(
          Exception('getAddressWithCoordinate failed: ${e.toString()}'));
    }
  }

  // 날씨 category 에 따른 정보 가져오기
  Future<WeatherCategory> getWeatherCode(String category) async {
    final jsonString = await rootBundle.loadString('assets/data/code.json');
    final jsonObject = jsonDecode(jsonString);
    return WeatherCategory.fromJson(jsonObject[category]);
  }

  // 초단기 실황
  Future<Result<List<Ncst>>> getUltraStrNcst() async {
    final localList = await _dao.getAllUltraNcstList();

    // get location
    Position position = await locationRepository.getLocation();
    var gpsToData = ConvertGps.gpsToGRID(position.latitude, position.longitude);
    int x = gpsToData['x'];
    int y = gpsToData['y'];
    //print(gpsToData);

    String dt = DateTime.now()
        .toString()
        .replaceAll(RegExp("[^0-9\\s]"), "")
        .replaceAll(" ", "");
    String date = dt.substring(0, 8);
    String time = dt.substring(8, 12);
    String checkTime = dt.substring(8, 10);

    // local
    if (localList.isNotEmpty) {
      if (localList[0].baseTime != null) {
        String localTime = localList[0].baseTime!.substring(0, 2);
        String localDate = localList[0].baseDate ?? '';
        if (date == localDate) {
          if (checkTime != localTime) {
            if (int.parse('${checkTime}30') > int.parse(time)) {
              print('getUltraStrNcst() -> local return');
              return Result.success(localList.map((e) => e.toNcst()).toList());
            }
          } else {
            print('getUltraStrNcst() -> local return');
            return Result.success(localList.map((e) => e.toNcst()).toList());
          }
        }
      }
    }

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
  Future<Result<List<Fcst>>> getUltraStrFcst(bool fetchFromRemote) async {
    final localList = await _dao.getAllUltraFcstList();

    final isDbEmpty = localList.isEmpty;
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    // local
    if (shouldJustLoadFromCache) {
      return Result.success(localList.map((e) => e.toFcst()).toList());
    }

    // remote
    try {
      final response =
          await _api.getUltraStrFcst('20230518', '2330', 55, 127, 1);
      final jsonResult = jsonDecode(response.body);
      FcstList list = FcstList.fromJson(jsonResult['response']['body']);
      List<Fcst> result = [];
      if (list.items?.item != null) {
        for (var item in list.items!.item!) {
          item.weatherCategory = await getWeatherCode(item.category ?? '');
          result.add(item);
        }
      }
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('getUltraStrFcst failed: ${e.toString()}'));
    }
  }

  // 단기 예보
  Future<Result<List<Fcst>>> getVilageFast(bool fetchFromRemote) async {
    final localList = await _dao.getAllVillageFcstList();

    final isDbEmpty = localList.isEmpty;
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    // local
    if (shouldJustLoadFromCache) {
      return Result.success(localList.map((e) => e.toFcst()).toList());
    }

    // remote
    try {
      final response = await _api.getVilageFcst('20230518', '2300', 55, 127, 1);
      final jsonResult = jsonDecode(response.body);
      FcstList list = FcstList.fromJson(jsonResult['response']['body']);
      List<Fcst> result = [];
      if (list.items?.item != null) {
        for (var item in list.items!.item!) {
          item.weatherCategory = await getWeatherCode(item.category ?? '');
          result.add(item);
        }
      }
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('getUltraStrFcst failed: ${e.toString()}'));
    }
  }

  // 측정소별 미세먼지
  Future<Result<List<Dnsty>>> getMesureDnsty(String query) async {
    final localList = await _dao.getAllMesureDnstyList();

    // local
    if (localList.isNotEmpty) {
      if (localList[0].dataTime != null) {
        String dt = DateTime.now()
            .toString()
            .replaceAll(RegExp("[^0-9\\s]"), "")
            .replaceAll(" ", "");
        String currentTime = dt.substring(8, 10);
        String dataTime = localList[0].dataTime!;
        String prevTime =
            dataTime.substring(dataTime.length - 5, dataTime.length - 3);

        if (int.parse(currentTime) == int.parse(prevTime)) {
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
      _dao.clearMesureDnstyList();
      _dao.insertMesureDnstyList(result.map((e) => e.toDnstyEntity()).toList());
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('getMesureDnsty failed: ${e.toString()}'));
    }
  }
}

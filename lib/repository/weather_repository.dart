import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sweater/model/address.dart';
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
import 'package:sweater/utils/result.dart';

class WeatherRepository {
  final RemoteApi _api;
  final WeatherDao _dao;

  LocationRepository locationRepository = LocationRepository();

  WeatherRepository(this._api, this._dao);

  // 날씨 category 에 따른 정보 가져오기
  Future<WeatherCategory> getWeatherCode(String category) async {
    final jsonString = await rootBundle.loadString('assets/data/code.json');
    final jsonObject = jsonDecode(jsonString);
    return WeatherCategory.fromJson(jsonObject[category]);
  }

  // 좌표로 주소 검색
  Future<Result<Address>> getAddressWithCoordinate() async {
    Position position = await locationRepository.getLocation();
    // 주소
    try {
      final response = await _api.getAddressWithCoordinate(position.longitude, position.latitude);
      print(response.body);
    } catch (e) {
      return Result.error(Exception('getUltraStrNcst failed: ${e.toString()}'));
    }
    return
  }

  // 초단기 실황
  Future<Result<List<Ncst>>> getUltraStrNcst(bool fetchFromRemote) async {
    final localList = await _dao.getAllUltraNcstList();
    
    final isDbEmpty = localList.isEmpty;
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    // local
    if (shouldJustLoadFromCache) {
      return Result.success(localList.map((e) => e.toNcst()).toList());
    }

    // get location
    Position position = await locationRepository.getLocation();
    print(position.longitude);
    print(position.latitude);
    int x = position.longitude.toInt();
    int y = position.latitude.toInt();

    String dt = DateTime.now().toString().replaceAll(RegExp("[^0-9\\s]"), "").replaceAll(" ", "");
    String date = dt.substring(0, 8);
    //int t = int.parse();
    String time = dt.substring(8, 12);
    //print(t);

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
      final response = await _api.getUltraStrFcst('20230518', '2330', 55, 127, 1);
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
  Future<Result<List<Dnsty>>> getMesureDnsty(bool fetchFromRemote) async {
    final localList = await _dao.getAllMesureDnstyList();

    final isDbEmpty = localList.isEmpty;
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    // local
    if (shouldJustLoadFromCache) {
      return Result.success(localList.map((e) => e.toDnsty()).toList());
    }

    // remote
    try {
      final response = await _api.getMsrstnAcctoRltmMesureDnsty('강서구');
      final jsonResult = jsonDecode(response.body);
      DnstyList list = DnstyList.fromJson(jsonResult['response']['body']);
      List<Dnsty> result = [];
      if (list.items != null) {
        for (var item in list.items!) {
          result.add(item);
        }
      }
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('getMesureDnsty failed: ${e.toString()}'));
    }
  }
}

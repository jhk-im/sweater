import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sweater/model/ncst.dart';
import 'package:sweater/model/ncst_list.dart';
import 'package:sweater/model/weather_category.dart';
import 'package:sweater/repository/mapper/weather_mapper.dart';
import 'package:sweater/repository/source/local/weather_dao.dart';
import 'package:sweater/repository/source/remote/weather_api.dart';
import 'package:sweater/utils/result.dart';

class WeatherRepository {
  final WeatherApi _api;
  final WeatherDao _dao;

  WeatherRepository(this._api, this._dao);

  Future<WeatherCategory> getWeatherCode(String category) async {
    final jsonString = await rootBundle.loadString('assets/data/code.json');
    final jsonObject = jsonDecode(jsonString);
    return WeatherCategory.fromJson(jsonObject[category]);
  }

  Future<Result<List<Ncst>>> getUltraStrNcst(bool fetchFromRemote) async {
    final localList = await _dao.getAllUltraNcstList();
    
    final isDbEmpty = localList.isEmpty;
    final shouldJustLoadFromCache = !isDbEmpty && !fetchFromRemote;

    // local
    if (shouldJustLoadFromCache) {
      return Result.success(localList.map((e) => e.toNcst()).toList());
    }

    // remote
    try {
      final response = await _api.getUltraStrNcst('20230518', '1400', 55, 127);
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
}

import 'package:hive/hive.dart';
import 'package:sweater/repository/source/local/entity/address_entity.dart';
import 'package:sweater/repository/source/local/entity/fine_dust_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_code_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_term_land_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_term_temperature_entity.dart';
import 'package:sweater/repository/source/local/entity/ultraviolet_entity.dart';
import 'package:sweater/repository/source/local/entity/weather_item_entity.dart';
import 'package:sweater/repository/source/local/entity/observatory_entity.dart';
import 'package:sweater/repository/source/local/entity/sun_rise_entity.dart';

class WeatherDao {
  static const userAddress = 'userAddress';
  Future<void> insertAddress(AddressEntity address) async {
    final box = await Hive.openBox<AddressEntity>(userAddress);
    await box.add(address);
  }

  Future<void> updateAddress(AddressEntity address) async {
    final box = await Hive.openBox<AddressEntity>(userAddress);
    await box.put(address.code, address);
  }

  Future clearAddress() async {
    final box = await Hive.openBox<AddressEntity>(userAddress);
    await box.clear();
  }

  Future<List<AddressEntity>> getAllAddressList() async {
    final box = await Hive.openBox<AddressEntity>(userAddress);
    return box.values.toList();
  }

  static const ultraShortTermLive = 'ultraShortTermLive';
  Future<void> insertUltraShortTermLiveList(
      List<WeatherItemEntity> weatherItemEntity) async {
    final box = await Hive.openBox<WeatherItemEntity>(ultraShortTermLive);
    await box.addAll(weatherItemEntity);
  }

  Future clearUltraShortTermLiveList() async {
    final box = await Hive.openBox<WeatherItemEntity>(ultraShortTermLive);
    await box.clear();
  }

  Future<List<WeatherItemEntity>> getAllUltraShortTermLiveList() async {
    final box = await Hive.openBox<WeatherItemEntity>(ultraShortTermLive);
    return box.values.toList();
  }

  static const todayShortTerm = 'todayShortTerm';
  Future<void> insertTodayShortTermList(
      List<WeatherItemEntity> weatherItemEntity) async {
    final box = await Hive.openBox<WeatherItemEntity>(todayShortTerm);
    await box.addAll(weatherItemEntity);
  }

  Future clearTodayShortTermList() async {
    final box = await Hive.openBox<WeatherItemEntity>(todayShortTerm);
    await box.clear();
  }

  Future<List<WeatherItemEntity>> getAllTodayShortTermList() async {
    final box = await Hive.openBox<WeatherItemEntity>(todayShortTerm);
    return box.values.toList();
  }

  static const yesterdayShortTerm = 'yesterdayShortTerm';
  Future<void> insertYesterdayShortTermList(
      List<WeatherItemEntity> weatherItemEntity) async {
    final box = await Hive.openBox<WeatherItemEntity>(yesterdayShortTerm);
    await box.addAll(weatherItemEntity);
  }

  Future clearYesterdayShortTermList() async {
    final box = await Hive.openBox<WeatherItemEntity>(yesterdayShortTerm);
    await box.clear();
  }

  Future<List<WeatherItemEntity>> getAllYesterdayShortTermList() async {
    final box = await Hive.openBox<WeatherItemEntity>(yesterdayShortTerm);
    return box.values.toList();
  }

  static const midTermLand = 'midTermLand';
  Future<void> insertMidTermLand(MidTermLandEntity entity) async {
    final box = await Hive.openBox<MidTermLandEntity>(midTermLand);
    await box.add(entity);
  }

  Future clearMidTermLandList() async {
    final box = await Hive.openBox<MidTermLandEntity>(midTermLand);
    await box.clear();
  }

  Future<List<MidTermLandEntity>> getAllMidTermLandList() async {
    final box = await Hive.openBox<MidTermLandEntity>(midTermLand);
    return box.values.toList();
  }

  static const midTermTemperature = 'midTermTemperature';
  Future<void> insertMidTermTemperature(MidTermTemperatureEntity entity) async {
    final box =
        await Hive.openBox<MidTermTemperatureEntity>(midTermTemperature);
    await box.add(entity);
  }

  Future clearMidTermTemperatureList() async {
    final box =
        await Hive.openBox<MidTermTemperatureEntity>(midTermTemperature);
    await box.clear();
  }

  Future<List<MidTermTemperatureEntity>> getAllMidTermTemperatureList() async {
    final box =
        await Hive.openBox<MidTermTemperatureEntity>(midTermTemperature);
    return box.values.toList();
  }

  static const midCode = 'midCode';
  Future<void> insertMidCodeList(List<MidCodeEntity> list) async {
    final box = await Hive.openBox<MidCodeEntity>(midCode);
    await box.addAll(list);
  }

  Future clearMidCodeList() async {
    final box = await Hive.openBox<MidCodeEntity>(midCode);
    await box.clear();
  }

  Future<List<MidCodeEntity>> getAllMidCodeList() async {
    final box = await Hive.openBox<MidCodeEntity>(midCode);
    return box.values.toList();
  }

  static const observatory = 'observatory';
  Future<void> insertObservatoryList(List<ObservatoryEntity> list) async {
    final box = await Hive.openBox<ObservatoryEntity>(observatory);
    await box.addAll(list);
  }

  Future clearObservatory() async {
    final box = await Hive.openBox<ObservatoryEntity>(observatory);
    await box.clear();
  }

  Future<List<ObservatoryEntity>> getAllObservatoryList() async {
    final box = await Hive.openBox<ObservatoryEntity>(observatory);
    return box.values.toList();
  }

  static const fineDust = 'fineDust';
  Future<void> insertFineDustList(List<FineDustEntity> list) async {
    final box = await Hive.openBox<FineDustEntity>(fineDust);
    await box.addAll(list);
  }

  Future clearFineDustList() async {
    final box = await Hive.openBox<FineDustEntity>(fineDust);
    await box.clear();
  }

  Future<List<FineDustEntity>> getAllFineDustList() async {
    final box = await Hive.openBox<FineDustEntity>(fineDust);
    return box.values.toList();
  }

  static const sunRise = 'sunRise';
  Future<void> insertSunRise(SunRiseEntity entity) async {
    final box = await Hive.openBox<SunRiseEntity>(sunRise);
    await box.add(entity);
  }

  Future clearSunRise() async {
    final box = await Hive.openBox<SunRiseEntity>(sunRise);
    await box.clear();
  }

  Future<List<SunRiseEntity>> getAllSunRise() async {
    final box = await Hive.openBox<SunRiseEntity>(sunRise);
    return box.values.toList();
  }

  static const ultraviolet = 'ultraviolet';
  Future<void> insertUltravioletList(
      List<UltravioletEntity> ultravioletEntities) async {
    final box = await Hive.openBox<UltravioletEntity>(ultraviolet);
    await box.addAll(ultravioletEntities);
  }

  Future clearUltravioletList() async {
    final box = await Hive.openBox<UltravioletEntity>(ultraviolet);
    await box.clear();
  }

  Future<List<UltravioletEntity>> getAllUltravioletList() async {
    final box = await Hive.openBox<UltravioletEntity>(ultraviolet);
    return box.values.toList();
  }
}

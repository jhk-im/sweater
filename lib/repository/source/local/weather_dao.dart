import 'package:hive/hive.dart';
import 'package:sweater/repository/source/local/entity/address_entity.dart';
import 'package:sweater/repository/source/local/entity/dnsty_entity.dart';
import 'package:sweater/repository/source/local/entity/fcst_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_code_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_land_fcst_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_ta_entity.dart';
import 'package:sweater/repository/source/local/entity/weather_item_entity.dart';
import 'package:sweater/repository/source/local/entity/observatory_entity.dart';
import 'package:sweater/repository/source/local/entity/rise_set_entity.dart';
import 'package:sweater/repository/source/local/entity/uv_rays_entity.dart';

class WeatherDao {
  /*static const observatory = 'observatory';
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

  static const midTa = 'midTa';
  Future<void> insertMidTa(MidTaEntity entity) async {
    final box = await Hive.openBox<MidTaEntity>(midTa);
    await box.add(entity);
  }

  Future clearMidTaList() async {
    final box = await Hive.openBox<MidTaEntity>(midTa);
    await box.clear();
  }

  Future<List<MidTaEntity>> getAllMidTaList() async {
    final box = await Hive.openBox<MidTaEntity>(midTa);
    return box.values.toList();
  }

  static const midLandFcst = 'midLandFcst';
  Future<void> insertMidLandFcst(MidLandFcstEntity entity) async {
    final box = await Hive.openBox<MidLandFcstEntity>(midLandFcst);
    await box.add(entity);
  }

  Future clearMidLandFcstList() async {
    final box = await Hive.openBox<MidLandFcstEntity>(midLandFcst);
    await box.clear();
  }

  Future<List<MidLandFcstEntity>> getAllMidLandFcstList() async {
    final box = await Hive.openBox<MidLandFcstEntity>(midLandFcst);
    return box.values.toList();
  }



  static const riseSet = 'riseSet';
  Future<void> insertRiseInfo(RiseSetEntity entity) async {
    final box = await Hive.openBox<RiseSetEntity>(riseSet);
    await box.add(entity);
  }

  Future clearRiseSet() async {
    final box = await Hive.openBox<RiseSetEntity>(riseSet);
    await box.clear();
  }

  Future<List<RiseSetEntity>> getAllRiseSet() async {
    final box = await Hive.openBox<RiseSetEntity>(riseSet);
    return box.values.toList();
  }

  static const mesureDnsty = 'mesureDnsty';
  Future<void> insertMesureDnstyList(List<DnstyEntity> list) async {
    final box = await Hive.openBox<DnstyEntity>(mesureDnsty);
    await box.addAll(list);
  }

  Future clearMesureDnstyList() async {
    final box = await Hive.openBox<DnstyEntity>(mesureDnsty);
    await box.clear();
  }

  Future<List<DnstyEntity>> getAllMesureDnstyList() async {
    final box = await Hive.openBox<DnstyEntity>(mesureDnsty);
    return box.values.toList();
  }

  static const uvRays = 'uvRays';
  Future<void> insertUVRaysList(List<UVRaysEntity> uvRaysEntities) async {
    final box = await Hive.openBox<UVRaysEntity>(uvRays);
    await box.addAll(uvRaysEntities);
  }

  Future clearUVRaysList() async {
    final box = await Hive.openBox<UVRaysEntity>(uvRays);
    await box.clear();
  }

  Future<List<UVRaysEntity>> getAllUVRaysList() async {
    final box = await Hive.openBox<UVRaysEntity>(uvRays);
    return box.values.toList();
  }

  static const vilageFcst = 'vilageFcst';
  static const prevVilageFcst = 'prevVilageFcst';
  Future<void> insertVilageFcstList(List<FcstEntity> list, bool isToday) async {
    if (isToday) {
      final box = await Hive.openBox<FcstEntity>(vilageFcst);
      await box.addAll(list);
    } else {
      final box = await Hive.openBox<FcstEntity>(prevVilageFcst);
      await box.addAll(list);
    }
  }

  Future clearVilageFcstList(bool isToday) async {
    if (isToday) {
      final box = await Hive.openBox<FcstEntity>(vilageFcst);
      await box.clear();
    } else {
      final box = await Hive.openBox<FcstEntity>(prevVilageFcst);
      await box.clear();
    }
  }

  Future<List<FcstEntity>> getAllVillageFcstList(bool isToday) async {
    if (isToday) {
      final box = await Hive.openBox<FcstEntity>(vilageFcst);
      return box.values.toList();
    } else {
      final box = await Hive.openBox<FcstEntity>(prevVilageFcst);
      return box.values.toList();
    }
  }*/

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
  Future<void> insertUltraShortTermLiveList(List<WeatherItemEntity> weatherItemEntity) async {
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
  Future<void> insertTodayShortTermList(List<WeatherItemEntity> weatherItemEntity) async {
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
  Future<void> insertYesterdayShortTermList(List<WeatherItemEntity> weatherItemEntity) async {
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

  /*static const ultraFcst = 'ultraFcst';
  Future<void> insertUltraFcstList(List<FcstEntity> fcstListEntities) async {
    final box = await Hive.openBox<FcstEntity>(ultraFcst);
    await box.addAll(fcstListEntities);
  }

  Future clearUltraFcstList() async {
    final box = await Hive.openBox<FcstEntity>(ultraFcst);
    await box.clear();
  }

  Future<List<FcstEntity>> getAllUltraFcstList() async {
    final box = await Hive.openBox<FcstEntity>(ultraFcst);
    return box.values.toList();
  }*/
}

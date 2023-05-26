import 'package:hive/hive.dart';
import 'package:sweater/repository/source/local/entity/address_entity.dart';
import 'package:sweater/repository/source/local/entity/dnsty_entity.dart';
import 'package:sweater/repository/source/local/entity/fcst_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_code_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_land_fcst_entity.dart';
import 'package:sweater/repository/source/local/entity/mid_ta_entity.dart';
import 'package:sweater/repository/source/local/entity/ncst_entity.dart';
import 'package:sweater/repository/source/local/entity/observatory_entity.dart';
import 'package:sweater/repository/source/local/entity/rise_set_entity.dart';
import 'package:sweater/repository/source/local/entity/uv_rays_entity.dart';

class WeatherDao {
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
  Future<void> insertVilageFcstList(List<FcstEntity> fcstListEntities) async {
    final box = await Hive.openBox<FcstEntity>(vilageFcst);
    await box.addAll(fcstListEntities);
  }

  Future clearVilageFcstList() async {
    final box = await Hive.openBox<FcstEntity>(vilageFcst);
    await box.clear();
  }

  Future<List<FcstEntity>> getAllVillageFcstList() async {
    final box = await Hive.openBox<FcstEntity>(vilageFcst);
    return box.values.toList();
  }

  static const ultraNcst = 'ultraNcst';
  static const ultraFcst = 'ultraFcst';
  Future<void> insertUltraNcstList(List<NcstEntity> ncstListEntities) async {
    final box = await Hive.openBox<NcstEntity>(ultraNcst);
    await box.addAll(ncstListEntities);
  }

  Future clearUltraNcstList() async {
    final box = await Hive.openBox<NcstEntity>(ultraNcst);
    await box.clear();
  }

  Future<List<NcstEntity>> getAllUltraNcstList() async {
    final box = await Hive.openBox<NcstEntity>(ultraNcst);
    return box.values.toList();
  }

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
  }
}

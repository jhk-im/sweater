import 'package:hive/hive.dart';
import 'package:sweater/repository/source/local/entity/address_entity.dart';
import 'package:sweater/repository/source/local/entity/dnsty_entity.dart';
import 'package:sweater/repository/source/local/entity/fcst_entity.dart';
import 'package:sweater/repository/source/local/entity/ncst_entity.dart';
import 'package:sweater/repository/source/local/entity/observatory_entity.dart';
import 'package:sweater/repository/source/local/entity/rise_set_entity.dart';
import 'package:sweater/repository/source/local/entity/uv_rays_entity.dart';

class WeatherDao {
  static const observatoryList = 'observatoryList';
  Future<void> insertObservatoryList(
      List<ObservatoryEntity> observatoryList
      ) async {
    final box = await Hive.openBox<ObservatoryEntity>('observatoryList');
    await box.addAll(observatoryList);
  }
  Future<ObservatoryEntity?> getObservatory(String depth1, String depth2) async {
    final box = await Hive.openBox<ObservatoryEntity>('observatoryList');
    return box.get(depth1);
  }
  Future clearObservatory() async {
    final box = await Hive.openBox<ObservatoryEntity>('observatoryList');
    await box.clear();
  }
  Future<List<ObservatoryEntity>> getAllObservatoryList() async {
    final box = await Hive.openBox<ObservatoryEntity>('observatoryList');
    return box.values.toList();
  }

  static const addressList = 'addressList';
  Future<void> insertAddress(
      AddressEntity address
      ) async {
    final box = await Hive.openBox<AddressEntity>('address');
    await box.add(address);
  }
  Future<void> updateAddress(
      AddressEntity address
      ) async {
    final box = await Hive.openBox<AddressEntity>('address');
    await box.put(address.code, address);
  }
  Future clearAddress() async {
    final box = await Hive.openBox<AddressEntity>('address');
    await box.clear();
  }
  Future<List<AddressEntity>> getAllAddressList() async {
    final box = await Hive.openBox<AddressEntity>('address');
    return box.values.toList();
  }

  static const riseSet = 'riseSet';
  Future<void> insertRiseInfo(
      RiseSetEntity riseSet
      ) async {
    final box = await Hive.openBox<RiseSetEntity>('riseSet');
    await box.add(riseSet);
  }
  Future clearRiseSet() async {
    final box = await Hive.openBox<RiseSetEntity>('riseSet');
    await box.clear();
  }
  Future<List<RiseSetEntity>> getAllRiseSet() async {
    final box = await Hive.openBox<RiseSetEntity>('riseSet');
    return box.values.toList();
  }

  static const mesureDnstyList = 'mesureDnstyList';
  Future<void> insertMesureDnstyList(
      List<DnstyEntity> dnstyEntities
      ) async {
    final box = await Hive.openBox<DnstyEntity>('mesureDnsty');
    await box.addAll(dnstyEntities);
  }
  Future clearMesureDnstyList() async {
    final box = await Hive.openBox<DnstyEntity>('mesureDnsty');
    await box.clear();
  }
  Future<List<DnstyEntity>> getAllMesureDnstyList() async {
    final box = await Hive.openBox<DnstyEntity>('mesureDnsty');
    return box.values.toList();
  }

  static const uvRaysList = 'uvRaysList';
  Future<void> insertUVRaysList(
      List<UVRaysEntity> uvRaysEntities
      ) async {
    final box = await Hive.openBox<UVRaysEntity>('uvRaysList');
    await box.addAll(uvRaysEntities);
  }
  Future clearUVRaysList() async {
    final box = await Hive.openBox<UVRaysEntity>('uvRaysList');
    await box.clear();
  }
  Future<List<UVRaysEntity>> getAllUVRaysList() async {
    final box = await Hive.openBox<UVRaysEntity>('uvRaysList');
    return box.values.toList();
  }

  static const ultraNcstList = 'ultraNcstList';
  static const ultraFcstList = 'ultraFcstList';
  static const vilageFcstList = 'vilageFcstList';
  Future<void> insertUltraNcstList(
      List<NcstEntity> ncstListEntities) async {
    final box = await Hive.openBox<NcstEntity>('ultraNcst');
    await box.addAll(ncstListEntities);
  }
  Future clearUltraNcstList() async {
    final box = await Hive.openBox<NcstEntity>('ultraNcst');
    await box.clear();
  }
  Future<List<NcstEntity>> getAllUltraNcstList() async {
    final box = await Hive.openBox<NcstEntity>('ultraNcst');
    return box.values.toList();
  }
  Future<void> insertUltraFcstList(
      List<FcstEntity> fcstListEntities
      ) async {
    final box = await Hive.openBox<FcstEntity>('ultraFcst');
    await box.addAll(fcstListEntities);
  }
  Future clearUltraFcstList() async {
    final box = await Hive.openBox<FcstEntity>('ultraFcst');
    await box.clear();
  }
  Future<List<FcstEntity>> getAllUltraFcstList() async {
    final box = await Hive.openBox<FcstEntity>('ultraFcst');
    return box.values.toList();
  }
  Future<void> insertVilageFcstList(
      List<FcstEntity> fcstListEntities
      ) async {
    final box = await Hive.openBox<FcstEntity>('vilageFcst');
    await box.addAll(fcstListEntities);
  }
  Future clearVilageFcstList() async {
    final box = await Hive.openBox<FcstEntity>('vilageFcst');
    await box.clear();
  }
  Future<List<FcstEntity>> getAllVillageFcstList() async {
    final box = await Hive.openBox<FcstEntity>('vilageFcst');
    return box.values.toList();
  }
}

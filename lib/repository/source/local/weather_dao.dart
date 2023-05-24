import 'package:hive/hive.dart';
import 'package:sweater/repository/source/local/entity/address_entity.dart';
import 'package:sweater/repository/source/local/entity/dnsty_entity.dart';
import 'package:sweater/repository/source/local/entity/fcst_entity.dart';
import 'package:sweater/repository/source/local/entity/ncst_entity.dart';
import 'package:sweater/repository/source/local/entity/rise_set_entity.dart';

class WeatherDao {
  static const ultraNcstList = 'ultraNcstList';
  static const ultraFcstList = 'ultraFcstList';
  static const vilageFcstList = 'vilageFcstList';
  static const mesureDnstyList = 'mesureDnstyList';
  static const addressList = 'addressList';
  static const riseSet = 'riseSet';

  // ultraNcst 추가
  Future<void> insertUltraNcstList(
      List<NcstEntity> ncstListEntities) async {
    final box = await Hive.openBox<NcstEntity>('ultraNcst');
    await box.addAll(ncstListEntities);
  }

  // ultraNcst 클리어
  Future clearUltraNcstList() async {
    final box = await Hive.openBox<NcstEntity>('ultraNcst');
    await box.clear();
  }

  // ultraNcst getAll
  Future<List<NcstEntity>> getAllUltraNcstList() async {
    final box = await Hive.openBox<NcstEntity>('ultraNcst');
    return box.values.toList();
  }

  // ultraFcst 추가
  Future<void> insertUltraFcstList(
      List<FcstEntity> fcstListEntities
      ) async {
    final box = await Hive.openBox<FcstEntity>('ultraFcst');
    await box.addAll(fcstListEntities);
  }

  // ultraFcst 클리어
  Future clearUltraFcstList() async {
    final box = await Hive.openBox<FcstEntity>('ultraFcst');
    await box.clear();
  }

  // ultraFcst getAll
  Future<List<FcstEntity>> getAllUltraFcstList() async {
    final box = await Hive.openBox<FcstEntity>('ultraFcst');
    return box.values.toList();
  }

  // vilageFcst 추가
  Future<void> insertVilageFcstList(
      List<FcstEntity> fcstListEntities
      ) async {
    final box = await Hive.openBox<FcstEntity>('vilageFcst');
    await box.addAll(fcstListEntities);
  }

  // vilageFcst 클리어
  Future clearVilageFcstList() async {
    final box = await Hive.openBox<FcstEntity>('vilageFcst');
    await box.clear();
  }

  // vilageFcst getAll
  Future<List<FcstEntity>> getAllVillageFcstList() async {
    final box = await Hive.openBox<FcstEntity>('vilageFcst');
    return box.values.toList();
  }

  // mesureDnsty 추가
  Future<void> insertMesureDnstyList(
      List<DnstyEntity> dnstyEntities
      ) async {
    final box = await Hive.openBox<DnstyEntity>('mesureDnsty');
    await box.addAll(dnstyEntities);
  }

  // mesureDnsty 클리어
  Future clearMesureDnstyList() async {
    final box = await Hive.openBox<DnstyEntity>('mesureDnsty');
    await box.clear();
  }

  // mesureDnsty getAll
  Future<List<DnstyEntity>> getAllMesureDnstyList() async {
    final box = await Hive.openBox<DnstyEntity>('mesureDnsty');
    return box.values.toList();
  }

  // address 추가
  Future<void> insertAddressList(
      AddressEntity address
      ) async {
    final box = await Hive.openBox<AddressEntity>('address');
    await box.put(address.code, address);
  }

  // mesureDnsty 클리어
  Future deleteAddress(String code) async {
    final box = await Hive.openBox<AddressEntity>('address');
    await box.delete(code);
  }

  // mesureDnsty getAll
  Future<List<AddressEntity>> getAllAddressList() async {
    final box = await Hive.openBox<AddressEntity>('address');
    return box.values.toList();
  }

  // riseSet 추가
  Future<void> insertRiseInfo(
      RiseSetEntity riseSet
      ) async {
    final box = await Hive.openBox<RiseSetEntity>('riseSet');
    await box.add(riseSet);
  }

  // riseSet 클리어
  Future clearRiseInfo() async {
    final box = await Hive.openBox<RiseSetEntity>('riseSet');
    await box.clear();
  }

  // riseSet getAll
  Future<List<RiseSetEntity>> getAllRiseSet() async {
    final box = await Hive.openBox<RiseSetEntity>('riseSet');
    return box.values.toList();
  }
}

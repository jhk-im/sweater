import 'package:hive/hive.dart';
import 'package:sweater/repository/source/local/fcst_entity.dart';
import 'package:sweater/repository/source/local/ncst_entity.dart';

class WeatherDao {
  static const weatherUltraNcstList = 'weatherUltraNcstList';
  static const weatherUltraFcstList = 'weatherUltraFcstList';

  // ultraNcst 추가
  Future<void> insertUltraNcstList(
      List<NcstEntity> ultraNcstListEntities) async {
    final box = await Hive.openBox<NcstEntity>('ultraNcst');
    await box.addAll(ultraNcstListEntities);
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
      List<FcstEntity> ultraFcstListEntities
      ) async {
    final box = await Hive.openBox<FcstEntity>('ultraFcst');
    await box.addAll(ultraFcstListEntities);
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
      List<FcstEntity> ultraFcstListEntities
      ) async {
    final box = await Hive.openBox<FcstEntity>('vilageFcst');
    await box.addAll(ultraFcstListEntities);
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
}

import 'package:hive/hive.dart';

part 'fcst_entity.g.dart';

@HiveType(typeId: 1)
class FcstEntity extends HiveObject {
  @HiveField(0)
  String category;
  @HiveField(1)
  String fcstValue;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? unit;
  @HiveField(4)
  List<String>? codeValues;
  @HiveField(5)
  String? fcstDate;
  @HiveField(6)
  String? fcstTime;
  @HiveField(7)
  String? baseDate;
  @HiveField(8)
  String? baseTime;
  @HiveField(9)
  int? nx;
  @HiveField(10)
  int? ny;
  FcstEntity({required this.category, required this.fcstValue});
}

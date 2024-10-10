import 'package:hive/hive.dart';

part 'ultra_short_term_entity.g.dart';

@HiveType(typeId: 0)
class UltraShortTermEntity extends HiveObject {
  @HiveField(0)
  String category;
  @HiveField(1)
  String obsrValue;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? unit;
  @HiveField(4)
  List<String>? codeValues;
  @HiveField(5)
  String? baseDate;
  @HiveField(6)
  String? baseTime;
  @HiveField(7)
  int? nx;
  @HiveField(8)
  int? ny;
  UltraShortTermEntity({required this.category, required this.obsrValue});
}
import 'package:hive/hive.dart';

part 'mid_ta_entity.g.dart';

@HiveType(typeId: 8)
class MidTaEntity extends HiveObject {
  @HiveField(0)
  String? regId;
  @HiveField(1)
  int? taMin3;
  @HiveField(2)
  int? taMax3;
  @HiveField(3)
  int? taMin4;
  @HiveField(4)
  int? taMax4;
  @HiveField(5)
  int? taMin5;
  @HiveField(6)
  int? taMax5;
  @HiveField(7)
  int? taMin6;
  @HiveField(8)
  int? taMax6;
  @HiveField(9)
  int? taMin7;
  @HiveField(10)
  int? taMax7;
  @HiveField(11)
  int? taMin8;
  @HiveField(12)
  int? taMax8;
  @HiveField(13)
  int? taMin9;
  @HiveField(14)
  int? taMax9;
  @HiveField(15)
  int? taMin10;
  @HiveField(16)
  int? taMax10;
  @HiveField(17)
  String? date;
}
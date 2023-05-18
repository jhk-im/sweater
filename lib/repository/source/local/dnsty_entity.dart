import 'package:hive/hive.dart';

part 'dnsty_entity.g.dart';

@HiveType(typeId: 2)
class DnstyEntity extends HiveObject {
  @HiveField(0)
  String? so2Grade;
  @HiveField(1)
  String? coFlag;
  @HiveField(2)
  String? khaiValue;
  @HiveField(3)
  String? so2Value;
  @HiveField(4)
  String? coValue;
  @HiveField(5)
  String? pm10Flag;
  @HiveField(6)
  String? pm10Value;
  @HiveField(7)
  String? o3Grade;
  @HiveField(8)
  String? khaiGrade;
  @HiveField(9)
  String? no2Flag;
  @HiveField(10)
  String? no2Grade;
  @HiveField(11)
  String? o3Flag;
  @HiveField(12)
  String? so2Flag;
  @HiveField(13)
  String? dataTime;
  @HiveField(14)
  String? coGrade;
  @HiveField(15)
  String? no2Value;
  @HiveField(16)
  String? pm10Grade;
  @HiveField(17)
  String? o3Value;
}
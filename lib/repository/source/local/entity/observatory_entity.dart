import 'package:hive/hive.dart';

part 'observatory_entity.g.dart';

@HiveType(typeId: 5)
class ObservatoryEntity extends HiveObject {
  @HiveField(0)
  int? code;
  @HiveField(1)
  String? depth1;
  @HiveField(2)
  String? depth2;
  @HiveField(3)
  String? depth3;
  @HiveField(4)
  int? gridX;
  @HiveField(5)
  int? gridY;
  @HiveField(6)
  int? lonHour;
  @HiveField(7)
  int? lonMin;
  @HiveField(8)
  double? lonSec;
  @HiveField(9)
  int? latHour;
  @HiveField(10)
  int? latMin;
  @HiveField(11)
  double? latSec;
  @HiveField(12)
  double? longitude;
  @HiveField(13)
  double? latitude;
}
import 'package:hive/hive.dart';

@HiveType(typeId: 4)
class RiseSetEntity extends HiveObject {
  @HiveField(0)
  int? locdate;
  @HiveField(1)
  String? location;
  @HiveField(2)
  int? sunrise;
  @HiveField(3)
  int? sunset;
  @HiveField(4)
  int? moonrise;
  @HiveField(5)
  int? moonset;
  @HiveField(6)
  double? longitudeNum;
  @HiveField(7)
  double? latitudeNum;
  // int? astm;
  // int? civile;
  // int? civilm;
  // int? latitude;
  // int? aste;
  // int? longitude;
  // int? moontransit;
  // int? naute;
  // int? nautm;
  // int? suntransit;
}

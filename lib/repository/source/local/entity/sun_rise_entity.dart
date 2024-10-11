import 'package:hive/hive.dart';

part 'sun_rise_entity.g.dart';

@HiveType(typeId: 4)
class SunRiseEntity extends HiveObject {
  @HiveField(0)
  String? locdate;
  @HiveField(1)
  String? location;
  @HiveField(2)
  String? sunrise;
  @HiveField(3)
  String? sunset;
  @HiveField(4)
  String? moonrise;
  @HiveField(5)
  String? moonset;
  @HiveField(6)
  String? longitudeNum;
  @HiveField(7)
  String? latitudeNum;
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

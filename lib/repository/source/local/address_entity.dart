import 'package:hive/hive.dart';

part 'address_entity.g.dart';

@HiveType(typeId: 3)
class AddressEntity extends HiveObject {
  @HiveField(0)
  String? addressName;

  @HiveField(1)
  String? region1depthName;

  @HiveField(2)
  String? region2depthName;

  @HiveField(3)
  String? region3depthName;

  @HiveField(4)
  String? region4depthName;

  @HiveField(5)
  double? x;

  @HiveField(6)
  double? y;

  @HiveField(7)
  String? code;

  @HiveField(8)
  String? regionType;
}
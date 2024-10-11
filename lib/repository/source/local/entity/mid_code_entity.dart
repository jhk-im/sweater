import 'package:hive/hive.dart';

part 'mid_code_entity.g.dart';

@HiveType(typeId: 7)
class MidCodeEntity extends HiveObject {
  @HiveField(0)
  String? city;
  @HiveField(1)
  String? code;
}

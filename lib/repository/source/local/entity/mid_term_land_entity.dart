import 'package:hive/hive.dart';

part 'mid_term_land_entity.g.dart';

@HiveType(typeId: 9)
class MidTermLandEntity extends HiveObject {
  @HiveField(0)
  String? regId;
  @HiveField(1)
  int? rnSt3Am;
  @HiveField(2)
  int? rnSt3Pm;
  @HiveField(3)
  int? rnSt4Am;
  @HiveField(4)
  int? rnSt4Pm;
  @HiveField(5)
  int? rnSt5Am;
  @HiveField(6)
  int? rnSt5Pm;
  @HiveField(7)
  int? rnSt6Am;
  @HiveField(8)
  int? rnSt6Pm;
  @HiveField(9)
  int? rnSt7Am;
  @HiveField(10)
  int? rnSt7Pm;
  @HiveField(11)
  int? rnSt8;
  @HiveField(12)
  int? rnSt9;
  @HiveField(13)
  int? rnSt10;
  @HiveField(14)
  String? wf3Am;
  @HiveField(15)
  String? wf3Pm;
  @HiveField(16)
  String? wf4Am;
  @HiveField(17)
  String? wf4Pm;
  @HiveField(18)
  String? wf5Am;
  @HiveField(19)
  String? wf5Pm;
  @HiveField(20)
  String? wf6Am;
  @HiveField(21)
  String? wf6Pm;
  @HiveField(22)
  String? wf7Am;
  @HiveField(23)
  String? wf7Pm;
  @HiveField(24)
  String? wf8;
  @HiveField(25)
  String? wf9;
  @HiveField(26)
  String? wf10;
  @HiveField(27)
  String? date;
}

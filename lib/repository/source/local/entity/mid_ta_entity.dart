import 'package:hive/hive.dart';

part 'mid_ta_entity.g.dart';

@HiveType(typeId: 8)
class MidTaEntity extends HiveObject {
  @HiveField(0)
  String? regId;
  @HiveField(1)
  int? taMin3;
  @HiveField(2)
  int? taMin3Low;
  @HiveField(3)
  int? taMin3High;
  @HiveField(4)
  int? taMax3;
  @HiveField(5)
  int? taMax3Low;
  @HiveField(6)
  int? taMax3High;
  @HiveField(7)
  int? taMin4;
  @HiveField(8)
  int? taMin4Low;
  @HiveField(9)
  int? taMin4High;
  @HiveField(10)
  int? taMax4;
  @HiveField(11)
  int? taMax4Low;
  @HiveField(12)
  int? taMax4High;
  @HiveField(13)
  int? taMin5;
  @HiveField(14)
  int? taMin5Low;
  @HiveField(15)
  int? taMin5High;
  @HiveField(16)
  int? taMax5;
  @HiveField(17)
  int? taMax5Low;
  @HiveField(18)
  int? taMax5High;
  @HiveField(19)
  int? taMin6;
  @HiveField(20)
  int? taMin6Low;
  @HiveField(21)
  int? taMin6High;
  @HiveField(22)
  int? taMax6;
  @HiveField(23)
  int? taMax6Low;
  @HiveField(24)
  int? taMax6High;
  @HiveField(25)
  int? taMin7;
  @HiveField(26)
  int? taMin7Low;
  @HiveField(27)
  int? taMin7High;
  @HiveField(28)
  int? taMax7;
  @HiveField(29)
  int? taMax7Low;
  @HiveField(30)
  int? taMax7High;
  @HiveField(31)
  int? taMin8;
  @HiveField(32)
  int? taMin8Low;
  @HiveField(33)
  int? taMin8High;
  @HiveField(34)
  int? taMax8;
  @HiveField(35)
  int? taMax8Low;
  @HiveField(36)
  int? taMax8High;
  @HiveField(37)
  int? taMin9;
  @HiveField(38)
  int? taMin9Low;
  @HiveField(39)
  int? taMin9High;
  @HiveField(40)
  int? taMax9;
  @HiveField(41)
  int? taMax9Low;
  @HiveField(42)
  int? taMax9High;
  @HiveField(43)
  int? taMin10;
  @HiveField(44)
  int? taMin10Low;
  @HiveField(45)
  int? taMin10High;
  @HiveField(46)
  int? taMax10;
  @HiveField(47)
  int? taMax10Low;
  @HiveField(48)
  int? taMax10High;
  @HiveField(49)
  String? date;
}
import 'package:hive/hive.dart';

part 'dnsty_entity.g.dart';

@HiveType(typeId: 2)
class DnstyEntity extends HiveObject {
  @HiveField(0)
  String? so2Grade; // 아황산가스
  @HiveField(1)
  String? coFlag; // 일산화탄소 플래그
  @HiveField(2)
  String? khaiValue; // 통합대기환경 수치
  @HiveField(3)
  String? so2Value; // 아황산가스 농도
  @HiveField(4)
  String? coValue; // 일산화탄소 농도
  @HiveField(5)
  String? pm10Flag; // 미세먼지플래그 (pm10)
  @HiveField(6)
  String? pm10Value; // 미세먼지 농도
  @HiveField(7)
  String? o3Grade; // 오존지수
  @HiveField(8)
  String? khaiGrade; // 통합대기환경 지수
  @HiveField(9)
  String? no2Flag; // 이산화질소 플래그
  @HiveField(10)
  String? no2Grade; // 이산화질소 지수
  @HiveField(11)
  String? o3Flag; // 오존 플래그
  @HiveField(12)
  String? so2Flag; // 아황산가스 플래그
  @HiveField(13)
  String? dataTime;
  @HiveField(14)
  String? coGrade; // 일산화탄소 지수
  @HiveField(15)
  String? no2Value; // 일산화질소 농도
  @HiveField(16)
  String? pm10Grade; // 미세먼지 24시간 등급
  @HiveField(17)
  String? o3Value; // 오존 농도
  @HiveField(18)
  String? pm25Value; // 초미세먼지
  @HiveField(19)
  String? pm25Value24; // 초미세먼지 24시간
  @HiveField(20)
  String? pm10Value24; // 미세먼지 24시간
}
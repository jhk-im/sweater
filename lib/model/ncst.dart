// 실황 조회
import 'package:sweater/model/weather_category.dart';

class Ncst {
  String? baseDate;
  String? baseTime;
  String? category;
  int? nx;
  int? ny;
  String? obsrValue;
  WeatherCategory? weatherCategory;

  Ncst(
      {this.baseDate,
        this.baseTime,
        this.category,
        this.nx,
        this.ny,
        this.obsrValue});

  Ncst.fromJson(Map<String, dynamic> json) {
    baseDate = json['baseDate'];
    baseTime = json['baseTime'];
    category = json['category'];
    nx = json['nx'];
    ny = json['ny'];
    obsrValue = json['obsrValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['baseDate'] = baseDate;
    data['baseTime'] = baseTime;
    data['category'] = category;
    data['nx'] = nx;
    data['ny'] = ny;
    data['obsrValue'] = obsrValue;
    return data;
  }
}
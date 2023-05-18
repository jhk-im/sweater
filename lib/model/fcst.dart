import 'package:sweater/model/weather_category.dart';

// 예보 조회
class Fcst {
  String? baseDate;
  String? baseTime;
  String? category;
  String? fcstDate;
  String? fcstTime;
  String? fcstValue;
  int? nx;
  int? ny;
  WeatherCategory? weatherCategory;

  Fcst(
      {this.baseDate,
      this.baseTime,
      this.category,
      this.fcstDate,
      this.fcstTime,
      this.fcstValue,
      this.nx,
      this.ny});

  Fcst.fromJson(Map<String, dynamic> json) {
    baseDate = json['baseDate'];
    baseTime = json['baseTime'];
    category = json['category'];
    fcstDate = json['fcstDate'];
    fcstTime = json['fcstTime'];
    fcstValue = json['fcstValue'];
    nx = json['nx'];
    ny = json['ny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['baseDate'] = baseDate;
    data['baseTime'] = baseTime;
    data['category'] = category;
    data['fcstDate'] = fcstDate;
    data['fcstTime'] = fcstTime;
    data['fcstValue'] = fcstValue;
    data['nx'] = nx;
    data['ny'] = ny;
    return data;
  }

  @override
  String toString() {
    return 'Fcst: { $weatherCategory, fcstValue: $fcstValue,  category: $category, nx: $nx, ny: $ny, fcstDate: $fcstDate, fcstTime: $fcstTime, baseDate: $baseDate, baseTime: $baseTime }';
  }
}

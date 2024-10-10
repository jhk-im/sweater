import 'package:sweater/repository/source/remote/model/weather_category.dart';

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

// 초단기 예보 조회, 단기 예보 조회
class FcstList {
  String? dataType;
  Items? items;
  int? pageNo;
  int? numOfRows;
  int? totalCount;

  FcstList(
      {this.dataType,
        this.items,
        this.pageNo,
        this.numOfRows,
        this.totalCount});

  FcstList.fromJson(Map<String, dynamic> json) {
    dataType = json['dataType'];
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
    pageNo = json['pageNo'];
    numOfRows = json['numOfRows'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dataType'] = dataType;
    if (items != null) {
      data['items'] = items!.toJson();
    }
    data['pageNo'] = pageNo;
    data['numOfRows'] = numOfRows;
    data['totalCount'] = totalCount;
    return data;
  }
}

class Items {
  List<Fcst>? item;

  Items({this.item});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      item = <Fcst>[];
      json['item'].forEach((v) {
        item!.add(Fcst.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (item != null) {
      data['item'] = item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

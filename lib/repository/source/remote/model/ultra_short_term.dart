import 'package:sweater/repository/source/remote/model/weather_category.dart';

// 초실황 조회
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

  @override
  String toString() {
    return 'Ncst: { $weatherCategory, obsrValue: $obsrValue,  category: $category, nx: $nx, ny: $ny, baseDate: $baseDate, baseTime: $baseTime }';
  }
}

// 초단기 실황 조회
class NcstList {
  String? dataType;
  Items? items;
  int? pageNo;
  int? numOfRows;
  int? totalCount;

  NcstList(
      {this.dataType,
        this.items,
        this.pageNo,
        this.numOfRows,
        this.totalCount});

  NcstList.fromJson(Map<String, dynamic> json) {
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
  List<Ncst>? item;

  Items({this.item});

  Items.fromJson(Map<String, dynamic> json) {
    if (json['item'] != null) {
      item = <Ncst>[];
      json['item'].forEach((v) {
        item!.add(Ncst.fromJson(v));
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


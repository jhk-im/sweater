import 'package:json_annotation/json_annotation.dart';
import 'package:sweater/repository/source/remote/model/weather_category.dart';

part 'ultra_short_term_response.g.dart';

@JsonSerializable()
class UltraShortTermResponse {
  final ResponseData response;

  UltraShortTermResponse({
    required this.response,
  });

  factory UltraShortTermResponse.fromJson(Map<String, dynamic> json) =>
      _$UltraShortTermResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UltraShortTermResponseToJson(this);
}

@JsonSerializable()
class ResponseData {
  final ResponseHeader? header;
  final ResponseBody? body;

  ResponseData({
    this.header,
    this.body,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}

@JsonSerializable()
class ResponseHeader {
  final String? resultCode;
  final String? resultMsg;

  ResponseHeader({
    this.resultCode,
    this.resultMsg,
  });

  factory ResponseHeader.fromJson(Map<String, dynamic> json) =>
      _$ResponseHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseHeaderToJson(this);
}

@JsonSerializable()
class ResponseBody {
  final String? dataType;
  final Items? items;
  final int? pageNo;
  final int? numOfRows;
  final int? totalCount;

  ResponseBody({
    this.dataType,
    this.items,
    this.pageNo,
    this.numOfRows,
    this.totalCount,
  });

  factory ResponseBody.fromJson(Map<String, dynamic> json) =>
      _$ResponseBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBodyToJson(this);
}

@JsonSerializable()
class Items {
  final List<UltraShortTerm>? item;

  Items({
    this.item,
  });

  factory Items.fromJson(Map<String, dynamic> json) =>
      _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class UltraShortTerm {
  final String? baseDate;
  final String? baseTime;
  final String? category;
  final int? nx;
  final int? ny;
  final String? obsrValue;
  WeatherCategory? weatherCategory;

  UltraShortTerm({
    this.baseDate,
    this.baseTime,
    this.category,
    this.nx,
    this.ny,
    this.obsrValue,
  });

  factory UltraShortTerm.fromJson(Map<String, dynamic> json) =>
      _$UltraShortTermFromJson(json);

  Map<String, dynamic> toJson() => _$UltraShortTermToJson(this);
}

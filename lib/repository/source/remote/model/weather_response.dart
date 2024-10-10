import 'package:json_annotation/json_annotation.dart';
import 'package:sweater/repository/source/remote/model/weather_category.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  final ResponseData response;

  WeatherResponse({
    required this.response,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
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
  final List<WeatherItem>? item;

  Items({
    this.item,
  });

  factory Items.fromJson(Map<String, dynamic> json) =>
      _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class WeatherItem {
  final String? baseDate;
  final String? baseTime;
  final String? category;
  final String? fcstDate;
  final String? fcstTime;
  final String? fcstValue;
  final int? nx;
  final int? ny;
  final String? obsrValue;
  WeatherCategory? weatherCategory;

  WeatherItem({
    this.baseDate,
    this.baseTime,
    this.category,
    this.fcstDate,
    this.fcstTime,
    this.fcstValue,
    this.nx,
    this.ny,
    this.obsrValue,
  });

  factory WeatherItem.fromJson(Map<String, dynamic> json) =>
      _$WeatherItemFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherItemToJson(this);
}

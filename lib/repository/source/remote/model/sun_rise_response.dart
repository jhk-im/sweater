import 'package:json_annotation/json_annotation.dart';

part 'sun_rise_response.g.dart';

@JsonSerializable()
class SunRiseResponse {
  final ResponseData response;

  SunRiseResponse({
    required this.response,
  });

  factory SunRiseResponse.fromJson(Map<String, dynamic> json) =>
      _$SunRiseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SunRiseResponseToJson(this);
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
  final List<SunRise>? item;

  Items({
    this.item,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class SunRise {
  String? locdate;
  String? location;
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? longitudeNum;
  String? latitudeNum;

  SunRise({
    this.locdate,
    this.location,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.longitudeNum,
    this.latitudeNum,
  });

  factory SunRise.fromJson(Map<String, dynamic> json) =>
      _$SunRiseFromJson(json);

  Map<String, dynamic> toJson() => _$SunRiseToJson(this);
}

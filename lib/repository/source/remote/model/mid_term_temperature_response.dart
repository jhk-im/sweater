import 'package:json_annotation/json_annotation.dart';

part 'mid_term_temperature_response.g.dart';

@JsonSerializable()
class MidTermTemperatureResponse {
  final ResponseData response;

  MidTermTemperatureResponse({
    required this.response,
  });

  factory MidTermTemperatureResponse.fromJson(Map<String, dynamic> json) =>
      _$MidTermTemperatureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MidTermTemperatureResponseToJson(this);
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
  final List<MidTermTemperature>? item;

  Items({
    this.item,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class MidTermTemperature {
  String? regId;
  int? taMin3;
  int? taMax3;
  int? taMin4;
  int? taMax4;
  int? taMin5;
  int? taMax5;
  int? taMin6;
  int? taMax6;
  int? taMin7;
  int? taMax7;
  int? taMin8;
  int? taMax8;
  int? taMin9;
  int? taMax9;
  int? taMin10;
  int? taMax10;
  String? date;

  MidTermTemperature({
    this.regId,
    this.taMin3,
    this.taMax3,
    this.taMin4,
    this.taMax4,
    this.taMin5,
    this.taMax5,
    this.taMin6,
    this.taMax6,
    this.taMin7,
    this.taMax7,
    this.taMin8,
    this.taMax8,
    this.taMin9,
    this.taMax9,
    this.taMin10,
    this.taMax10,
  });

  factory MidTermTemperature.fromJson(Map<String, dynamic> json) =>
      _$MidTermTemperatureFromJson(json);

  Map<String, dynamic> toJson() => _$MidTermTemperatureToJson(this);
}

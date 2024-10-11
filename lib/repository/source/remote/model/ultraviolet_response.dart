import 'package:json_annotation/json_annotation.dart';

part 'ultraviolet_response.g.dart';

@JsonSerializable()
class UltravioletResponse {
  final ResponseData response;

  UltravioletResponse({
    required this.response,
  });

  factory UltravioletResponse.fromJson(Map<String, dynamic> json) =>
      _$UltravioletResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UltravioletResponseToJson(this);
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
  final List<Ultraviolet>? item;

  Items({
    this.item,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class Ultraviolet {
  String? code;
  String? areaNo;
  String? date;
  String? h0;
  String? h3;
  String? h6;
  String? h9;
  String? h12;
  String? h15;
  String? h18;
  String? h21;
  String? h24;

  Ultraviolet({
    this.code,
    this.areaNo,
    this.date,
    this.h0,
    this.h3,
    this.h6,
    this.h9,
    this.h12,
    this.h15,
    this.h18,
    this.h21,
    this.h24,
  });

  factory Ultraviolet.fromJson(Map<String, dynamic> json) =>
      _$UltravioletFromJson(json);

  Map<String, dynamic> toJson() => _$UltravioletToJson(this);
}

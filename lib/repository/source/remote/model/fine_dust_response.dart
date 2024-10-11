import 'package:json_annotation/json_annotation.dart';

part 'fine_dust_response.g.dart';

@JsonSerializable()
class FineDustResponse {
  final ResponseData response;

  FineDustResponse({
    required this.response,
  });

  factory FineDustResponse.fromJson(Map<String, dynamic> json) =>
      _$FineDustResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FineDustResponseToJson(this);
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
  int? totalCount;
  List<FineDust>? items;
  int? pageNo;
  int? numOfRows;

  ResponseBody({
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
  final List<FineDust>? item;

  Items({
    this.item,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class FineDust {
  String? so2Grade;
  String? coFlag;
  String? khaiValue;
  String? so2Value;
  String? coValue;
  String? pm10Flag;
  String? pm10Value;
  String? pm10Value24;
  String? pm25Value;
  String? pm25Value24;
  String? o3Grade;
  String? khaiGrade;
  String? no2Flag;
  String? no2Grade;
  String? o3Flag;
  String? so2Flag;
  String? dataTime;
  String? coGrade;
  String? no2Value;
  String? pm10Grade;
  String? o3Value;

  FineDust({
    this.so2Grade,
    this.coFlag,
    this.khaiValue,
    this.so2Value,
    this.coValue,
    this.pm10Flag,
    this.pm10Value,
    this.pm10Value24,
    this.pm25Value,
    this.pm25Value24,
    this.o3Grade,
    this.khaiGrade,
    this.no2Flag,
    this.no2Grade,
    this.o3Flag,
    this.so2Flag,
    this.dataTime,
    this.coGrade,
    this.no2Value,
    this.pm10Grade,
    this.o3Value,
  });

  factory FineDust.fromJson(Map<String, dynamic> json) =>
      _$FineDustFromJson(json);

  Map<String, dynamic> toJson() => _$FineDustToJson(this);
}

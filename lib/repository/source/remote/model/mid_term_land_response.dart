import 'package:json_annotation/json_annotation.dart';

part 'mid_term_land_response.g.dart';

@JsonSerializable()
class MidTermLandResponse {
  final ResponseData response;

  MidTermLandResponse({
    required this.response,
  });

  factory MidTermLandResponse.fromJson(Map<String, dynamic> json) =>
      _$MidTermLandResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MidTermLandResponseToJson(this);
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
  final List<MidTermLand>? item;

  Items({
    this.item,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class MidTermLand {
  final String? regId;
  final int? rnSt3Am;
  final int? rnSt3Pm;
  final int? rnSt4Am;
  final int? rnSt4Pm;
  final int? rnSt5Am;
  final int? rnSt5Pm;
  final int? rnSt6Am;
  final int? rnSt6Pm;
  final int? rnSt7Am;
  final int? rnSt7Pm;
  final int? rnSt8;
  final int? rnSt9;
  final int? rnSt10;
  final String? wf3Am;
  final String? wf3Pm;
  final String? wf4Am;
  final String? wf4Pm;
  final String? wf5Am;
  final String? wf5Pm;
  final String? wf6Am;
  final String? wf6Pm;
  final String? wf7Am;
  final String? wf7Pm;
  final String? wf8;
  final String? wf9;
  final String? wf10;
  String? date;

  MidTermLand({
    this.regId,
    this.rnSt3Am,
    this.rnSt3Pm,
    this.rnSt4Am,
    this.rnSt4Pm,
    this.rnSt5Am,
    this.rnSt5Pm,
    this.rnSt6Am,
    this.rnSt6Pm,
    this.rnSt7Am,
    this.rnSt7Pm,
    this.rnSt8,
    this.rnSt9,
    this.rnSt10,
    this.wf3Am,
    this.wf3Pm,
    this.wf4Am,
    this.wf4Pm,
    this.wf5Am,
    this.wf5Pm,
    this.wf6Am,
    this.wf6Pm,
    this.wf7Am,
    this.wf7Pm,
    this.wf8,
    this.wf9,
    this.wf10,
  });

  factory MidTermLand.fromJson(Map<String, dynamic> json) =>
      _$MidTermLandFromJson(json);

  Map<String, dynamic> toJson() => _$MidTermLandToJson(this);
}

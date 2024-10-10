import 'package:json_annotation/json_annotation.dart';

part 'address_response.g.dart';

@JsonSerializable()
class AddressResponse {
  final int? code;
  final String? msg;
  final Meta? meta;
  final List<AddressResult>? documents;

  AddressResponse({
    this.code,
    this.msg,
    this.meta,
    this.documents,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: 'total_count')
  final int? totalCount;

  Meta({
    this.totalCount,
  });

  factory Meta.fromJson(Map<String, dynamic> json) =>
      _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class AddressResult {
  @JsonKey(name: 'region_type')
  final String? regionType;
  final String? code;
  @JsonKey(name: 'address_name')
  final String? addressName;
  @JsonKey(name: 'region_1depth_name')
  final String? region1depthName;
  @JsonKey(name: 'region_2depth_name')
  final String? region2depthName;
  @JsonKey(name: 'region_3depth_name')
  final String? region3depthName;
  @JsonKey(name: 'region_4depth_name')
  final String? region4depthName;
  final double? x;
  final double? y;

  AddressResult({
    this.regionType,
    this.code,
    this.addressName,
    this.region1depthName,
    this.region2depthName,
    this.region3depthName,
    this.region4depthName,
    this.x,
    this.y
  });

  factory AddressResult.fromJson(Map<String, dynamic> json) =>
      _$AddressResultFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResultToJson(this);
}

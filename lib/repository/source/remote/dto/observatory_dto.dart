import 'package:freezed_annotation/freezed_annotation.dart';

part 'observatory_dto.freezed.dart';
part 'observatory_dto.g.dart';

@freezed
class ObservatoryDto with _$ObservatoryDto {
  const factory ObservatoryDto({
    required int code,
    required String depth1,
    required String depth2,
    required String depth3,
    required int gridX,
    required int gridY,
    required int lonHour,
    required int lonMin,
    required double lonSec,
    required int latHour,
    required int latMin,
    required double latSec,
    required double longitude,
    required double latitude,
  }) = _ObservatoryDto;

  factory ObservatoryDto.fromJson(Map<String, Object?> json)
  => _$ObservatoryDtoFromJson(json);
}
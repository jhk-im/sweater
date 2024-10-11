import 'package:freezed_annotation/freezed_annotation.dart';

part 'mid_code_dto.freezed.dart';
part 'mid_code_dto.g.dart';

@freezed
class MidCodeDto with _$MidCodeDto {
  const factory MidCodeDto({
    required String city,
    required String code,
  }) = _MidCodeDto;

  factory MidCodeDto.fromJson(Map<String, Object?> json) =>
      _$MidCodeDtoFromJson(json);
}

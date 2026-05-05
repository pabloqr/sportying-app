import 'package:freezed_annotation/freezed_annotation.dart';

part 'complex_dto.freezed.dart';
part 'complex_dto.g.dart';

@freezed
abstract class ComplexDto with _$ComplexDto {
  const factory ComplexDto({
    required int id,
    @JsonKey(name: 'complexName') required String name,
    required String timeIni,
    required String timeEnd,
    required double? locLongitude,
    required double? locLatitude,
    required List<String> sports,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ComplexDto;

  factory ComplexDto.fromJson(Map<String, dynamic> json) => _$ComplexDtoFromJson(json);
}

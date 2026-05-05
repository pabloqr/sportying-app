import 'package:freezed_annotation/freezed_annotation.dart';

part 'court_dto.freezed.dart';
part 'court_dto.g.dart';

@freezed
abstract class CourtDto with _$CourtDto {
  const factory CourtDto({
    required int id,
    required int complexId,
    required String sport,
    required String name,
    required String description,
    required int maxPeople,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CourtDto;

  factory CourtDto.fromJson(Map<String, dynamic> json) => _$CourtDtoFromJson(json);
}

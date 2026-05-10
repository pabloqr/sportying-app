import 'package:freezed_annotation/freezed_annotation.dart';

part 'court_availability_dto.freezed.dart';
part 'court_availability_dto.g.dart';

@freezed
abstract class CourtAvailabilitySlotDto with _$CourtAvailabilitySlotDto {
  const factory CourtAvailabilitySlotDto({
    required DateTime dateIni,
    required DateTime dateEnd,
    required bool available,
  }) = _CourtAvailabilitySlotDto;

  factory CourtAvailabilitySlotDto.fromJson(Map<String, dynamic> json) => _$CourtAvailabilitySlotDtoFromJson(json);
}

@freezed
abstract class CourtAvailabilityDto with _$CourtAvailabilityDto {
  const factory CourtAvailabilityDto({
    required int id,
    required int complexId,
    required List<CourtAvailabilitySlotDto> availability,
  }) = _CourtAvailabilityDto;

  factory CourtAvailabilityDto.fromJson(Map<String, dynamic> json) => _$CourtAvailabilityDtoFromJson(json);
}

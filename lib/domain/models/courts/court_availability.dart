import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';

part 'court_availability.freezed.dart';
part 'court_availability.g.dart';

@freezed
abstract class CourtAvailabilitySlot with _$CourtAvailabilitySlot {
  const factory CourtAvailabilitySlot({required DateTime dateIni, required DateTime dateEnd, required bool available}) =
      _CourtAvailabilitySlot;

  factory CourtAvailabilitySlot.fromJson(Map<String, Object?> json) => _$CourtAvailabilitySlotFromJson(json);
}

@freezed
abstract class CourtAvailability with _$CourtAvailability {
  const factory CourtAvailability({
    required int id,
    required Complex complex,
    required List<CourtAvailabilitySlot> availability,
  }) = _CourtAvailability;

  factory CourtAvailability.fromJson(Map<String, Object?> json) => _$CourtAvailabilityFromJson(json);
}

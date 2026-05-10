import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/courts/court.dart';

part 'court_availability.freezed.dart';

@freezed
abstract class CourtAvailabilitySlot with _$CourtAvailabilitySlot {
  const factory CourtAvailabilitySlot({required DateTime dateIni, required DateTime dateEnd, required bool available}) =
      _CourtAvailabilitySlot;
}

@freezed
abstract class CourtAvailability with _$CourtAvailability {
  const factory CourtAvailability({
    required Court court,
    required Complex complex,
    required List<CourtAvailabilitySlot> availability,
    required DateTime nextAvailable,
  }) = _CourtAvailability;
}

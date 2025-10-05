import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportying_app/domain/models/reservations/availability_status.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/domain/models/reservations/time_filter.dart';

part 'reservation.freezed.dart';
part 'reservation.g.dart';

@freezed
abstract class Reservation with _$Reservation {
  const factory Reservation({
    int? id,
    required userId,
    required int complexId,
    required int courtId,
    required DateTime dateIni,
    required DateTime dateEnd,
    required AvailabilityStatus status,
    required ReservationStatus reservationStatus,
    required TimeFilter timeFilter,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Reservation;

  factory Reservation.fromJson(Map<String, Object?> json) => _$ReservationFromJson(json);
}

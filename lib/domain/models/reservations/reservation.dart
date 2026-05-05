import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/reservations/availability_status.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/domain/models/reservations/time_filter.dart';

part 'reservation.freezed.dart';

@freezed
abstract class Reservation with _$Reservation {
  const factory Reservation({
    required int id,
    required int userId,
    required Complex complex,
    required Court court,
    required DateTime dateIni,
    required DateTime dateEnd,
    required AvailabilityStatus status,
    required ReservationStatus reservationStatus,
    required TimeFilter timeFilter,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Reservation;
}

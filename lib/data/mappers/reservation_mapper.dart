import 'package:sportying_app/data/services/remote/reservations/models/reservation_dto.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/reservations/availability_status.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/domain/models/reservations/time_filter.dart';

extension ReservationDtoMapper on ReservationDto {
  Reservation toDomain(Complex complex, Court court) {
    return Reservation(
      id: id,
      userId: userId,
      complex: complex,
      court: court,
      dateIni: dateIni,
      dateEnd: dateEnd,
      status: AvailabilityStatus.values.byName(status.toLowerCase()),
      reservationStatus: ReservationStatus.values.byName(reservationStatus.toLowerCase()),
      timeFilter: TimeFilter.values.byName(timeFilter.toLowerCase()),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ReservationMapper on Reservation {
  ReservationDto toDto() {
    return ReservationDto(
      id: id,
      userId: userId,
      complexId: complex.id,
      courtId: court.id,
      dateIni: dateIni,
      dateEnd: dateEnd,
      status: status.toString(),
      reservationStatus: reservationStatus.toString(),
      timeFilter: timeFilter.toString(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

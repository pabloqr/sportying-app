import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/data/mappers/reservation_mapper.dart';
import 'package:sportying_app/data/services/remote/reservations/models/reservation_dto.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_status.dart';
import 'package:sportying_app/domain/models/reservations/availability_status.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/domain/models/reservations/time_filter.dart';

void main() {
  group('ReservationMapper Tests', () {
    final now = DateTime.now();

    final complex = Complex(
      id: 10,
      name: 'Complex 10',
      timeIni: '08:00',
      timeEnd: '22:00',
      address: 'Madrid, Spain',
      locLatitude: 40.416775,
      locLongitude: -3.703790,
      sports: {Sport.football},
      createdAt: now,
      updatedAt: now,
    );

    final court = Court(
      id: 1,
      complex: complex,
      sport: Sport.football,
      name: 'Court 1',
      description: 'Main Football Court',
      maxPeople: 22,
      status: CourtStatus.open,
      createdAt: now,
      updatedAt: now,
    );

    final dto = ReservationDto(
      id: 100,
      userId: 5,
      complexId: 10,
      courtId: 1,
      dateIni: now,
      dateEnd: now.add(const Duration(hours: 1)),
      status: 'occupied',
      reservationStatus: 'scheduled',
      timeFilter: 'upcoming',
      createdAt: now,
      updatedAt: now,
    );

    final domain = Reservation(
      id: 100,
      userId: 5,
      complex: complex,
      court: court,
      dateIni: now,
      dateEnd: now.add(const Duration(hours: 1)),
      status: AvailabilityStatus.occupied,
      reservationStatus: ReservationStatus.scheduled,
      timeFilter: TimeFilter.upcoming,
      createdAt: now,
      updatedAt: now,
    );

    test('toDomain maps DTO to domain correctly', () {
      final result = dto.toDomain(complex, court);

      expect(result.id, equals(domain.id));
      expect(result.userId, equals(domain.userId));
      expect(result.complex, equals(domain.complex));
      expect(result.court, equals(domain.court));
      expect(result.dateIni, equals(domain.dateIni));
      expect(result.dateEnd, equals(domain.dateEnd));
      expect(result.status, equals(domain.status));
      expect(result.reservationStatus, equals(domain.reservationStatus));
      expect(result.timeFilter, equals(domain.timeFilter));
      expect(result.createdAt, equals(domain.createdAt));
      expect(result.updatedAt, equals(domain.updatedAt));
    });

    test('toDto maps domain to DTO correctly', () {
      final result = domain.toDto();

      expect(result.id, equals(dto.id));
      expect(result.userId, equals(dto.userId));
      expect(result.complexId, equals(dto.complexId));
      expect(result.courtId, equals(dto.courtId));
      expect(result.dateIni, equals(dto.dateIni));
      expect(result.dateEnd, equals(dto.dateEnd));
      expect(result.status, contains(dto.status));
      expect(result.reservationStatus, contains(dto.reservationStatus));
      expect(result.timeFilter, contains(dto.timeFilter));
      expect(result.createdAt, equals(dto.createdAt));
      expect(result.updatedAt, equals(dto.updatedAt));
    });
  });
}

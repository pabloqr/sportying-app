import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/core/utils/extension_utils.dart';
import 'package:sportying_app/data/mappers/court_availability_mapper.dart';
import 'package:sportying_app/data/services/remote/courts/models/court_availability_dto.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_availability.dart';
import 'package:sportying_app/domain/models/courts/court_status.dart';

void main() {
  group('CourtAvailabilityMapper and SlotMapper Tests', () {
    final now = DateTime.now().toUtc();
    final expectedNowCeil = now.ceilNextHalfHour;

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

    test('toDomain maps empty availability slots to now.ceilNextHalfHour', () {
      final dto = CourtAvailabilityDto(id: 1, complexId: 10, availability: []);

      final domain = dto.toDomain(court, complex);

      expect(domain.court, equals(court));
      expect(domain.complex, equals(complex));
      expect(domain.availability, isEmpty);
      expect(domain.nextAvailable.difference(expectedNowCeil).inMinutes.abs() < 2, isTrue);
    });

    test('toDomain maps DTO to domain with occupied slots and calculates next available time correctly', () {
      // Create occupied slots:
      // First slot is occupied starting in 2 hours
      final slot1Start = expectedNowCeil.add(const Duration(hours: 2));
      final slot1End = expectedNowCeil.add(const Duration(hours: 3));

      // There is an available slot from +0 to +2
      final dto = CourtAvailabilityDto(
        id: 1,
        complexId: 10,
        availability: [
          CourtAvailabilitySlotDto(dateIni: expectedNowCeil, dateEnd: slot1Start, available: true),
          CourtAvailabilitySlotDto(dateIni: slot1Start, dateEnd: slot1End, available: false),
        ],
      );

      final domain = dto.toDomain(court, complex);
      expect(domain.availability.length, equals(2));
      expect(domain.availability[0].available, isTrue);
      expect(domain.availability[1].available, isFalse);

      // Since the first occupied slot starts in 2 hours (which is >= 1 hour gap from now), nextAvailable should be now (expectedNowCeil)
      expect(domain.nextAvailable.difference(expectedNowCeil).inMinutes.abs() < 2, isTrue);
    });

    test('toDomain maps DTO to domain with occupied slot right now and calculates next available correctly', () {
      // First slot occupied from now to +1h
      final slot1Start = expectedNowCeil;
      final slot1End = expectedNowCeil.add(const Duration(hours: 1));

      // Second slot occupied from +1h to +2h
      final slot2Start = slot1End;
      final slot2End = slot1End.add(const Duration(hours: 1));

      final dto = CourtAvailabilityDto(
        id: 1,
        complexId: 10,
        availability: [
          CourtAvailabilitySlotDto(dateIni: slot1Start, dateEnd: slot1End, available: false),
          CourtAvailabilitySlotDto(dateIni: slot2Start, dateEnd: slot2End, available: false),
        ],
      );

      final domain = dto.toDomain(court, complex);
      // Next available should be the end of the last occupied slot since there are no gaps
      expect(domain.nextAvailable.isAtSameMomentAs(slot2End), isTrue);
    });

    test('toDomain returns the start of the first one-hour gap between occupied slots', () {
      final firstEnd = expectedNowCeil.add(const Duration(hours: 1));
      final secondStart = firstEnd.add(const Duration(hours: 1));

      final dto = CourtAvailabilityDto(
        id: 1,
        complexId: 10,
        availability: [
          CourtAvailabilitySlotDto(dateIni: expectedNowCeil, dateEnd: firstEnd, available: false),
          CourtAvailabilitySlotDto(
            dateIni: secondStart,
            dateEnd: secondStart.add(const Duration(hours: 1)),
            available: false,
          ),
        ],
      );

      final domain = dto.toDomain(court, complex);

      expect(domain.nextAvailable, equals(firstEnd));
    });

    test('toDto maps domain to DTO correctly', () {
      final domain = CourtAvailability(
        court: court,
        complex: complex,
        availability: [
          CourtAvailabilitySlot(
            dateIni: expectedNowCeil,
            dateEnd: expectedNowCeil.add(const Duration(hours: 1)),
            available: true,
          ),
        ],
        nextAvailable: expectedNowCeil,
      );

      final dto = domain.toDto();
      expect(dto.id, equals(court.id));
      expect(dto.complexId, equals(complex.id));
      expect(dto.availability.length, equals(1));
      expect(dto.availability[0].dateIni, equals(expectedNowCeil));
      expect(dto.availability[0].available, isTrue);
    });
  });
}

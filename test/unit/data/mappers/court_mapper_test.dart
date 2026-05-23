import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/data/mappers/court_mapper.dart';
import 'package:sportying_app/data/services/remote/courts/models/court_dto.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_status.dart';

void main() {
  group('CourtMapper Tests', () {
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

    final dto = CourtDto(
      id: 1,
      complexId: 10,
      sport: 'football',
      name: 'Court 1',
      description: 'Main Football Court',
      maxPeople: 22,
      status: 'open',
      createdAt: now,
      updatedAt: now,
    );

    final domain = Court(
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

    test('toDomain maps DTO to domain correctly', () {
      final result = dto.toDomain(complex);

      expect(result.id, equals(domain.id));
      expect(result.complex, equals(domain.complex));
      expect(result.sport, equals(domain.sport));
      expect(result.name, equals(domain.name));
      expect(result.description, equals(domain.description));
      expect(result.maxPeople, equals(domain.maxPeople));
      expect(result.status, equals(domain.status));
      expect(result.createdAt, equals(domain.createdAt));
      expect(result.updatedAt, equals(domain.updatedAt));
    });

    test('toDto maps domain to DTO correctly', () {
      final result = domain.toDto();

      expect(result.id, equals(dto.id));
      expect(result.complexId, equals(dto.complexId));
      expect(result.sport, contains(dto.sport)); // Sport.football.toString() starts with/contains football
      expect(result.name, equals(dto.name));
      expect(result.description, equals(dto.description));
      expect(result.maxPeople, equals(dto.maxPeople));
      expect(result.status, contains(dto.status)); // CourtStatus.open.toString() contains open
      expect(result.createdAt, equals(dto.createdAt));
      expect(result.updatedAt, equals(dto.updatedAt));
    });
  });
}

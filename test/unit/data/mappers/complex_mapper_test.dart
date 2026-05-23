import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/data/mappers/complex_mapper.dart';
import 'package:sportying_app/data/services/remote/complexes/models/complex_dto.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';

void main() {
  group('ComplexMapper Tests', () {
    final now = DateTime.now();

    final dto = ComplexDto(
      id: 1,
      name: 'Complex 1',
      timeIni: '08:00',
      timeEnd: '22:00',
      locLatitude: 40.416775,
      locLongitude: -3.703790,
      sports: ['football', 'padel'],
      createdAt: now,
      updatedAt: now,
    );

    final domain = Complex(
      id: 1,
      name: 'Complex 1',
      timeIni: '08:00',
      timeEnd: '22:00',
      address: 'Madrid, Spain',
      locLatitude: 40.416775,
      locLongitude: -3.703790,
      sports: {Sport.football, Sport.padel},
      createdAt: now,
      updatedAt: now,
    );

    test('toDomain maps DTO to domain correctly with address', () {
      final result = dto.toDomain('Madrid, Spain');

      expect(result.id, equals(domain.id));
      expect(result.name, equals(domain.name));
      expect(result.timeIni, equals(domain.timeIni));
      expect(result.timeEnd, equals(domain.timeEnd));
      expect(result.address, equals(domain.address));
      expect(result.locLatitude, equals(domain.locLatitude));
      expect(result.locLongitude, equals(domain.locLongitude));
      expect(result.sports, equals(domain.sports));
      expect(result.createdAt, equals(domain.createdAt));
      expect(result.updatedAt, equals(domain.updatedAt));
    });

    test('toDto maps domain to DTO correctly', () {
      final result = domain.toDto();

      expect(result.id, equals(dto.id));
      expect(result.name, equals(dto.name));
      expect(result.timeIni, equals(dto.timeIni));
      expect(result.timeEnd, equals(dto.timeEnd));
      expect(result.locLatitude, equals(dto.locLatitude));
      expect(result.locLongitude, equals(dto.locLongitude));
      expect(result.sports, containsAll(dto.sports));
      expect(result.createdAt, equals(dto.createdAt));
      expect(result.updatedAt, equals(dto.updatedAt));
    });
  });
}

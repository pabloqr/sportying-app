import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/data/mappers/user_mapper.dart';
import 'package:sportying_app/data/services/remote/users/models/user_dto.dart';
import 'package:sportying_app/domain/models/users/user.dart';

void main() {
  group('UserMapper Tests', () {
    final now = DateTime.now();

    final dto = UserDto(
      id: 1,
      role: 'client',
      name: 'John',
      surname: 'Doe',
      mail: 'john.doe@example.com',
      phonePrefix: 34,
      phoneNumber: 123456789,
      createdAt: now,
      updatedAt: now,
    );

    final domain = User(
      id: 1,
      role: Role.client,
      name: 'John',
      surname: 'Doe',
      mail: 'john.doe@example.com',
      phonePrefix: 34,
      phoneNumber: 123456789,
      createdAt: now,
      updatedAt: now,
    );

    test('toDomain maps DTO to domain correctly', () {
      final result = dto.toDomain();

      expect(result.id, equals(domain.id));
      expect(result.role, equals(domain.role));
      expect(result.name, equals(domain.name));
      expect(result.surname, equals(domain.surname));
      expect(result.mail, equals(domain.mail));
      expect(result.phonePrefix, equals(domain.phonePrefix));
      expect(result.phoneNumber, equals(domain.phoneNumber));
      expect(result.createdAt, equals(domain.createdAt));
      expect(result.updatedAt, equals(domain.updatedAt));
    });

    test('toDto maps domain to DTO correctly', () {
      final result = domain.toDto();

      expect(result.id, equals(dto.id));
      expect(result.role, equals(dto.role));
      expect(result.name, equals(dto.name));
      expect(result.surname, equals(dto.surname));
      expect(result.mail, equals(dto.mail));
      expect(result.phonePrefix, equals(dto.phonePrefix));
      expect(result.phoneNumber, equals(dto.phoneNumber));
      expect(result.createdAt, equals(dto.createdAt));
      expect(result.updatedAt, equals(dto.updatedAt));
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/data/services/remote/auth/models/sign_in_dto.dart';
import 'package:sportying_app/data/services/remote/auth/models/sign_up_dto.dart';
import 'package:sportying_app/data/services/remote/courts/models/court_availability_dto.dart';

void main() {
  test('auth DTOs deserialize request fields', () {
    final signIn = SignInDto.fromJson({'mail': 'ada@example.com', 'password': 'secret'});
    final signUp = SignUpDto.fromJson({
      'name': 'Ada',
      'surname': 'Lovelace',
      'mail': 'ada@example.com',
      'phonePrefix': 34,
      'phoneNumber': 600000001,
      'password': 'secret',
    });

    expect(signIn.mail, equals('ada@example.com'));
    expect(signIn.password, equals('secret'));
    expect(signUp.name, equals('Ada'));
    expect(signUp.phoneNumber, equals(600000001));
  });

  test('court availability DTO deserializes nested slots', () {
    final result = CourtAvailabilityDto.fromJson({
      'id': 1,
      'complexId': 10,
      'availability': [
        {'dateIni': '2026-05-23T10:00:00.000Z', 'dateEnd': '2026-05-23T11:00:00.000Z', 'available': false},
      ],
    });

    expect(result.complexId, equals(10));
    expect(result.availability.single.available, isFalse);
    expect(result.availability.single.dateIni.hour, equals(10));
  });
}

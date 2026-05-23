import 'package:flutter_test/flutter_test.dart';
import 'package:sportying_app/data/mappers/auth/auth_credentials_mapper.dart';
import 'package:sportying_app/data/mappers/auth/sign_in_mapper.dart';
import 'package:sportying_app/data/mappers/auth/sign_up_mapper.dart';
import 'package:sportying_app/data/mappers/auth/tokens_mapper.dart';
import 'package:sportying_app/domain/models/auth/auth_credentials.dart';
import 'package:sportying_app/domain/models/auth/sign_in.dart';
import 'package:sportying_app/domain/models/auth/sign_up.dart';
import 'package:sportying_app/domain/models/auth/tokens.dart';
import 'package:sportying_app/domain/models/users/user.dart';

void main() {
  group('Auth Mappers Tests', () {
    final now = DateTime.now();

    group('SignInMapper', () {
      test('toDomain and toDto mapping', () {
        const domain = SignIn(mail: 'mail@mail.com', password: 'password123');
        final dto = domain.toDto();
        expect(dto.mail, equals(domain.mail));
        expect(dto.password, equals(domain.password));

        final backToDomain = dto.toDomain();
        expect(backToDomain.mail, equals(dto.mail));
        expect(backToDomain.password, equals(dto.password));
      });
    });

    group('SignUpMapper', () {
      test('toDomain and toDto mapping', () {
        const domain = SignUp(
          name: 'Name',
          surname: 'Surname',
          mail: 'mail@mail.com',
          phonePrefix: 34,
          phoneNumber: 123456789,
          password: 'password123',
        );
        final dto = domain.toDto();
        expect(dto.name, equals(domain.name));
        expect(dto.surname, equals(domain.surname));
        expect(dto.mail, equals(domain.mail));
        expect(dto.phonePrefix, equals(domain.phonePrefix));
        expect(dto.phoneNumber, equals(domain.phoneNumber));
        expect(dto.password, equals(domain.password));

        final backToDomain = dto.toDomain();
        expect(backToDomain.name, equals(dto.name));
        expect(backToDomain.surname, equals(dto.surname));
        expect(backToDomain.mail, equals(dto.mail));
        expect(backToDomain.phonePrefix, equals(dto.phonePrefix));
        expect(backToDomain.phoneNumber, equals(dto.phoneNumber));
        expect(backToDomain.password, equals(dto.password));
      });
    });

    group('TokensMapper', () {
      test('toDomain and toDto mapping', () {
        const domain = Tokens(accessToken: 'access', refreshToken: 'refresh', expiresIn: 3600);
        final dto = domain.toDto();
        expect(dto.accessToken, equals(domain.accessToken));
        expect(dto.refreshToken, equals(domain.refreshToken));
        expect(dto.expiresIn, equals(domain.expiresIn));

        final backToDomain = dto.toDomain();
        expect(backToDomain.accessToken, equals(dto.accessToken));
        expect(backToDomain.refreshToken, equals(dto.refreshToken));
        expect(backToDomain.expiresIn, equals(dto.expiresIn));
      });
    });

    group('AuthCredentialsMapper', () {
      test('toDomain and toDto mapping', () {
        final domain = AuthCredentials(
          accessToken: 'access',
          refreshToken: 'refresh',
          expiresIn: 3600,
          user: User(
            id: 1,
            role: Role.client,
            name: 'Name',
            surname: 'Surname',
            mail: 'mail@mail.com',
            phonePrefix: 34,
            phoneNumber: 123456789,
            createdAt: now,
            updatedAt: now,
          ),
        );

        final dto = domain.toDto();
        expect(dto.accessToken, equals(domain.accessToken));
        expect(dto.refreshToken, equals(domain.refreshToken));
        expect(dto.expiresIn, equals(domain.expiresIn));
        expect(dto.user.id, equals(domain.user.id));
        expect(dto.user.name, equals(domain.user.name));

        final backToDomain = dto.toDomain();
        expect(backToDomain.accessToken, equals(dto.accessToken));
        expect(backToDomain.refreshToken, equals(dto.refreshToken));
        expect(backToDomain.expiresIn, equals(dto.expiresIn));
        expect(backToDomain.user.id, equals(dto.user.id));
        expect(backToDomain.user.name, equals(dto.user.name));
      });
    });
  });
}

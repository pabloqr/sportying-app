import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sportying_app/core/storage/secure_storage_service.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/local/auth_local_service.dart';
import 'package:sportying_app/domain/models/auth/tokens.dart';
import 'package:sportying_app/domain/models/users/user.dart';

class MockSecureStorageService extends Mock implements SecureStorageService {}

void main() {
  late MockSecureStorageService storage;
  late AuthLocalService service;

  final user = User(
    id: 1,
    role: Role.client,
    name: 'Ada',
    surname: 'Lovelace',
    mail: 'ada@example.com',
    phonePrefix: 34,
    phoneNumber: 600000001,
    createdAt: DateTime.utc(2026, 1, 1),
    updatedAt: DateTime.utc(2026, 2, 1),
  );

  setUp(() {
    storage = MockSecureStorageService();
    service = AuthLocalService(secureStorage: storage);
  });

  test('getters return persisted token and expiry values', () async {
    final expiry = DateTime.utc(2026, 5, 23);
    when(() => storage.read('access_token')).thenAnswer((_) async => 'access');
    when(() => storage.read('refresh_token')).thenAnswer((_) async => 'refresh');
    when(() => storage.read('expires_in')).thenAnswer((_) async => expiry.millisecondsSinceEpoch.toString());

    expect((await service.getAccessToken() as Ok<String?>).value, equals('access'));
    expect((await service.getRefreshToken() as Ok<String?>).value, equals('refresh'));
    expect(
      (await service.getExpiresIn() as Ok<DateTime?>).value!.millisecondsSinceEpoch,
      equals(expiry.millisecondsSinceEpoch),
    );
  });

  test('null stored values are returned without parsing', () async {
    when(() => storage.read('expires_in')).thenAnswer((_) async => null);
    when(() => storage.read('user_model')).thenAnswer((_) async => null);

    expect((await service.getExpiresIn() as Ok<DateTime?>).value, isNull);
    expect((await service.getUser() as Ok<User?>).value, isNull);
  });

  test('storage read failures are returned as errors', () async {
    final failure = Exception('read failed');
    when(() => storage.read('access_token')).thenThrow(failure);
    when(() => storage.read('refresh_token')).thenThrow(failure);
    when(() => storage.read('user_model')).thenThrow(failure);

    expect((await service.getAccessToken() as Error<String?>).error, same(failure));
    expect((await service.getRefreshToken() as Error<String?>).error, same(failure));
    expect((await service.getUser() as Error<User?>).error, same(failure));
  });

  test('saveTokens persists tokens and an absolute expiration timestamp', () async {
    final writes = <String, String>{};
    when(() => storage.write(any(), any())).thenAnswer((invocation) async {
      writes[invocation.positionalArguments[0] as String] = invocation.positionalArguments[1] as String;
    });
    final before = DateTime.now().add(const Duration(seconds: 3600)).millisecondsSinceEpoch;

    final result = await service.saveTokens(
      const Tokens(accessToken: 'access', refreshToken: 'refresh', expiresIn: 3600),
    );
    final after = DateTime.now().add(const Duration(seconds: 3600)).millisecondsSinceEpoch;

    expect(result, isA<Ok<void>>());
    expect(writes['access_token'], equals('access'));
    expect(writes['refresh_token'], equals('refresh'));
    final expiresAt = int.parse(writes['expires_in']!);
    expect(expiresAt, inInclusiveRange(before - 5, after));
  });

  test('saveUser and getUser preserve all serialized fields', () async {
    String? storedUser;
    when(() => storage.write('user_model', any())).thenAnswer((invocation) async {
      storedUser = invocation.positionalArguments[1] as String;
    });

    expect(await service.saveUser(user), isA<Ok<void>>());

    when(() => storage.read('user_model')).thenAnswer((_) async => storedUser);
    final result = await service.getUser();

    expect(jsonDecode(storedUser!)['updatedAt'], equals(user.updatedAt.toIso8601String()));
    expect((result as Ok<User?>).value, equals(user));
  });

  test('getExpiresIn reports malformed stored timestamps as errors', () async {
    when(() => storage.read('expires_in')).thenAnswer((_) async => 'invalid');

    final result = await service.getExpiresIn();

    expect(result, isA<Error<DateTime?>>());
  });

  test('saveTokens and saveUser report write failures', () async {
    final failure = Exception('write failed');
    when(() => storage.write(any(), any())).thenThrow(failure);

    expect(
      (await service.saveTokens(const Tokens(accessToken: 'access', refreshToken: 'refresh', expiresIn: 3600))
              as Error<void>)
          .error,
      same(failure),
    );
    expect((await service.saveUser(user) as Error<void>).error, same(failure));
  });

  test('saveAuth reports a nested write failure', () async {
    final failure = Exception('write failed');
    when(() => storage.write('access_token', any())).thenAnswer((_) async {});
    when(() => storage.write('refresh_token', any())).thenAnswer((_) async {});
    when(() => storage.write('expires_in', any())).thenAnswer((_) async {});
    when(() => storage.write('user_model', any())).thenThrow(failure);

    final result = await service.saveAuth(
      const Tokens(accessToken: 'access', refreshToken: 'refresh', expiresIn: 3600),
      user,
    );

    expect((result as Error<void>).error, same(failure));
  });

  test('saveAuth persists both tokens and user when writes succeed', () async {
    when(() => storage.write(any(), any())).thenAnswer((_) async {});

    final result = await service.saveAuth(
      const Tokens(accessToken: 'access', refreshToken: 'refresh', expiresIn: 3600),
      user,
    );

    expect(result, isA<Ok<void>>());
    verify(() => storage.write('access_token', 'access')).called(1);
    verify(() => storage.write('refresh_token', 'refresh')).called(1);
    verify(() => storage.write('expires_in', any())).called(1);
    verify(() => storage.write('user_model', any())).called(1);
  });

  test('clearAuth deletes tokens and user data', () async {
    final deletedKeys = <String>[];
    when(() => storage.delete(any())).thenAnswer((invocation) async {
      deletedKeys.add(invocation.positionalArguments.single as String);
    });

    final result = await service.clearAuth();

    expect(result, isA<Ok<void>>());
    expect(deletedKeys, containsAll(['access_token', 'refresh_token', 'expires_in', 'user_model']));
  });

  test('clear operations return deletion failures', () async {
    final failure = Exception('delete failed');
    when(() => storage.delete(any())).thenThrow(failure);

    expect((await service.clearTokens() as Error<void>).error, same(failure));
    expect((await service.clearUser() as Error<void>).error, same(failure));
    expect((await service.clearAuth() as Error<void>).error, same(failure));
  });
}

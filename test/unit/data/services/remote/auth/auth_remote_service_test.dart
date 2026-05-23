import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportying_app/core/config/config_service.dart';
import 'package:sportying_app/core/utils/exceptions.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/remote/auth/auth_remote_service.dart';
import 'package:sportying_app/data/services/remote/auth/models/sign_in_dto.dart';
import 'package:sportying_app/data/services/remote/auth/models/sign_up_dto.dart';
import 'package:sportying_app/data/services/remote/auth/models/tokens_dto.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient client;
  late AuthRemoteServiceImpl service;

  const credentialsJson = {
    'accessToken': 'access',
    'refreshToken': 'refresh',
    'expiresIn': 3600,
    'user': {
      'id': 1,
      'role': 'client',
      'name': 'Ada',
      'surname': 'Lovelace',
      'mail': 'ada@example.com',
      'phonePrefix': 34,
      'phoneNumber': 600000001,
      'createdAt': '2026-01-01T00:00:00.000Z',
      'updatedAt': '2026-02-01T00:00:00.000Z',
    },
  };

  setUp(() async {
    SharedPreferences.setMockInitialValues({'api_url_override': 'https://api.test'});
    final preferences = await SharedPreferences.getInstance();
    client = MockHttpClient();
    service = AuthRemoteServiceImpl(
      client: client,
      configService: ConfigService(sharedPreferences: preferences),
    );
    registerFallbackValue(Uri.parse('https://api.test'));
  });

  test('signIn posts credentials to configured endpoint and maps response', () async {
    when(
      () => client.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => http.Response(jsonEncode(credentialsJson), 200));

    final result = await service.signIn(const SignInDto(mail: 'ada@example.com', password: 'password'));

    expect(result, isA<Ok>());
    expect((result as Ok).value.accessToken, equals('access'));
    final call = verify(
      () => client.post(
        captureAny(),
        headers: any(named: 'headers'),
        body: captureAny(named: 'body'),
      ),
    ).captured;
    expect(call.first as Uri, equals(Uri.parse('https://api.test/auth/signin')));
    expect(jsonDecode(call.last as String), containsPair('mail', 'ada@example.com'));
  });

  test('signUp posts user data and maps created credentials', () async {
    when(
      () => client.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => http.Response(jsonEncode(credentialsJson), 201));

    final result = await service.signUp(
      const SignUpDto(
        name: 'Ada',
        surname: 'Lovelace',
        mail: 'ada@example.com',
        phonePrefix: 34,
        phoneNumber: 600000001,
        password: 'password',
      ),
    );

    expect((result as Ok).value.user.name, equals('Ada'));
    final uri =
        verify(
              () => client.post(
                captureAny(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ),
            ).captured.single
            as Uri;
    expect(uri.path, equals('/auth/signup'));
  });

  test('signUp and signIn expose failed responses and client exceptions', () async {
    when(
      () => client.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => http.Response(jsonEncode({'message': 'invalid'}), 400));

    final signUpResult = await service.signUp(
      const SignUpDto(
        name: 'Ada',
        surname: null,
        mail: 'ada@example.com',
        phonePrefix: 34,
        phoneNumber: 600000001,
        password: 'password',
      ),
    );
    final signInResult = await service.signIn(const SignInDto(mail: 'ada@example.com', password: 'password'));

    expect(((signUpResult as Error).error as NetworkException).message, equals('invalid'));
    expect(((signInResult as Error).error as NetworkException).message, equals('invalid'));

    final failure = Exception('client failed');
    reset(client);
    when(
      () => client.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenThrow(failure);
    expect(
      (await service.signIn(const SignInDto(mail: 'ada@example.com', password: 'password')) as Error).error,
      same(failure),
    );

    expect(
      (await service.signUp(
                const SignUpDto(
                  name: 'Ada',
                  surname: null,
                  mail: 'ada@example.com',
                  phonePrefix: 34,
                  phoneNumber: 600000001,
                  password: 'password',
                ),
              )
              as Error)
          .error,
      same(failure),
    );
  });

  test('refreshAuth maps non-success API messages to NetworkException', () async {
    when(
      () => client.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => http.Response(jsonEncode({'message': 'expired'}), 401));

    final result = await service.refreshAuth('invalid');

    expect(result, isA<Error<TokensDto>>());
    expect((result as Error<TokensDto>).error, isA<NetworkException>());
    expect((result.error as NetworkException).message, equals('expired'));
  });

  test('refreshAuth maps successful token responses and client failures', () async {
    when(
      () => client.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer(
      (_) async => http.Response(jsonEncode({'accessToken': 'new', 'refreshToken': 'next', 'expiresIn': 900}), 200),
    );

    final success = await service.refreshAuth('refresh');

    expect((success as Ok<TokensDto>).value.accessToken, equals('new'));

    final failure = Exception('client failed');
    reset(client);
    when(
      () => client.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenThrow(failure);

    expect((await service.refreshAuth('refresh') as Error<TokensDto>).error, same(failure));
  });

  test('signOut sends its bearer token', () async {
    when(() => client.post(any(), headers: any(named: 'headers'))).thenAnswer((_) async => http.Response('', 200));

    final result = await service.signOut('access');

    expect(result, isA<Ok<void>>());
    final headers =
        verify(() => client.post(any(), headers: captureAny(named: 'headers'))).captured.single as Map<String, String>;
    expect(headers, containsPair('Authorization', 'Bearer access'));
  });

  test('signOut maps failed responses and client exceptions', () async {
    when(
      () => client.post(any(), headers: any(named: 'headers')),
    ).thenAnswer((_) async => http.Response(jsonEncode({'message': 'invalid'}), 401));

    final failureResponse = await service.signOut('access');

    expect(((failureResponse as Error<void>).error as NetworkException).message, equals('invalid'));

    final failure = Exception('client failed');
    reset(client);
    when(() => client.post(any(), headers: any(named: 'headers'))).thenThrow(failure);

    expect((await service.signOut('access') as Error<void>).error, same(failure));
  });

  test('all authentication requests return timeout failures', () async {
    final timeoutService = AuthRemoteServiceImpl(
      client: client,
      configService: ConfigService(sharedPreferences: await SharedPreferences.getInstance()),
      timeout: Duration.zero,
    );
    when(
      () => client.post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) => Completer<http.Response>().future);

    final signUp = await timeoutService.signUp(
      const SignUpDto(
        name: 'Ada',
        surname: null,
        mail: 'ada@example.com',
        phonePrefix: 34,
        phoneNumber: 600000001,
        password: 'password',
      ),
    );
    final signIn = await timeoutService.signIn(const SignInDto(mail: 'ada@example.com', password: 'password'));
    final refresh = await timeoutService.refreshAuth('refresh');

    reset(client);
    when(() => client.post(any(), headers: any(named: 'headers'))).thenAnswer((_) => Completer<http.Response>().future);
    final signOut = await timeoutService.signOut('access');

    expect((signUp as Error).error, isA<TimeoutException>());
    expect((signIn as Error).error, isA<TimeoutException>());
    expect((refresh as Error).error, isA<TimeoutException>());
    expect((signOut as Error).error, isA<TimeoutException>());
  });
}

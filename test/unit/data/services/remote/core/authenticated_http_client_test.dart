import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:sportying_app/core/utils/exceptions.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/auth/auth_repository.dart';
import 'package:sportying_app/data/services/remote/core/authenticated_http_client.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockHttpClient httpClient;
  late MockAuthRepository authRepository;
  late AuthenticatedHttpClient client;
  final uri = Uri.parse('https://example.test/resource');

  setUp(() {
    httpClient = MockHttpClient();
    authRepository = MockAuthRepository();
    client = AuthenticatedHttpClient(client: httpClient, authRepository: authRepository);
    when(() => authRepository.accessToken).thenReturn('access-token');
    when(() => authRepository.refreshToken).thenReturn('refresh-token');
  });

  test('get supplies JSON, custom, and bearer headers', () async {
    when(() => httpClient.get(uri, headers: any(named: 'headers'))).thenAnswer((_) async => http.Response('', 200));

    final response = await client.get(uri, headers: {'X-Trace': 'request-id'});

    expect(response.statusCode, equals(200));
    final capturedHeaders =
        verify(() => httpClient.get(uri, headers: captureAny(named: 'headers'))).captured.single as Map<String, String>;
    expect(capturedHeaders, containsPair('Authorization', 'Bearer access-token'));
    expect(capturedHeaders, containsPair('Content-Type', 'application/json'));
    expect(capturedHeaders, containsPair('X-Trace', 'request-id'));
  });

  test('requests omit authorization when there is no access token', () async {
    when(() => authRepository.accessToken).thenReturn(null);
    when(() => httpClient.get(uri, headers: any(named: 'headers'))).thenAnswer((_) async => http.Response('', 200));

    await client.get(uri);

    final headers =
        verify(() => httpClient.get(uri, headers: captureAny(named: 'headers'))).captured.single as Map<String, String>;
    expect(headers, isNot(contains('Authorization')));
  });

  test('retries once after refreshing authentication on an unauthorized response', () async {
    when(() => httpClient.get(uri, headers: any(named: 'headers'))).thenAnswer((_) async => http.Response('', 401));
    when(() => authRepository.refreshAuth('refresh-token')).thenAnswer((_) async => const Result.ok(null));

    final response = await client.get(uri);

    expect(response.statusCode, equals(401));
    verify(() => authRepository.refreshAuth('refresh-token')).called(1);
    verify(() => httpClient.get(uri, headers: any(named: 'headers'))).called(2);
  });

  test('converts authentication refresh failures into a network exception', () async {
    when(() => httpClient.get(uri, headers: any(named: 'headers'))).thenAnswer((_) async => http.Response('', 401));
    when(
      () => authRepository.refreshAuth('refresh-token'),
    ).thenAnswer((_) async => Result.error(Exception('refresh failed')));

    await expectLater(
      client.get(uri),
      throwsA(isA<NetworkException>().having((error) => error.message, 'message', contains('refresh failed'))),
    );
  });

  test('converts thrown requests into a network exception', () async {
    when(() => httpClient.get(uri, headers: any(named: 'headers'))).thenThrow(Exception('offline'));

    await expectLater(
      client.get(uri),
      throwsA(isA<NetworkException>().having((error) => error.message, 'message', contains('offline'))),
    );
  });

  test('converts initial request timeouts into network exceptions', () async {
    final timeoutClient = AuthenticatedHttpClient(
      client: httpClient,
      authRepository: authRepository,
      timeout: Duration.zero,
    );
    when(
      () => httpClient.get(uri, headers: any(named: 'headers')),
    ).thenAnswer((_) => Completer<http.Response>().future);

    await expectLater(
      timeoutClient.get(uri),
      throwsA(isA<NetworkException>().having((error) => error.message, 'message', contains('Connection timeout'))),
    );
  });

  test('converts retried request timeouts into network exceptions', () async {
    final timeoutClient = AuthenticatedHttpClient(
      client: httpClient,
      authRepository: authRepository,
      timeout: Duration.zero,
    );
    var requests = 0;
    when(() => httpClient.get(uri, headers: any(named: 'headers'))).thenAnswer((_) {
      requests++;
      if (requests == 1) return Future.value(http.Response('', 401));
      return Completer<http.Response>().future;
    });
    when(() => authRepository.refreshAuth('refresh-token')).thenAnswer((_) async => const Result.ok(null));

    await expectLater(timeoutClient.get(uri), throwsA(isA<NetworkException>()));
    expect(requests, equals(2));
  });

  test('post, put, and delete delegate body and headers', () async {
    when(
      () => httpClient.post(
        uri,
        headers: any(named: 'headers'),
        body: 'post-body',
      ),
    ).thenAnswer((_) async => http.Response('', 201));
    when(
      () => httpClient.put(
        uri,
        headers: any(named: 'headers'),
        body: 'put-body',
      ),
    ).thenAnswer((_) async => http.Response('', 200));
    when(() => httpClient.delete(uri, headers: any(named: 'headers'))).thenAnswer((_) async => http.Response('', 204));

    expect((await client.post(uri, body: 'post-body')).statusCode, equals(201));
    expect((await client.put(uri, body: 'put-body')).statusCode, equals(200));
    expect((await client.delete(uri)).statusCode, equals(204));

    verify(
      () => httpClient.post(
        uri,
        headers: any(named: 'headers'),
        body: 'post-body',
      ),
    ).called(1);
    verify(
      () => httpClient.put(
        uri,
        headers: any(named: 'headers'),
        body: 'put-body',
      ),
    ).called(1);
    verify(() => httpClient.delete(uri, headers: any(named: 'headers'))).called(1);
  });
}

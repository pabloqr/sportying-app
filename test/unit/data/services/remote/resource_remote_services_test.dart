import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:sportying_app/core/utils/exceptions.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/remote/complexes/complexes_remote_service.dart';
import 'package:sportying_app/data/services/remote/core/authenticated_http_client.dart';
import 'package:sportying_app/data/services/remote/courts/courts_remote_service.dart';
import 'package:sportying_app/data/services/remote/reservations/reservations_remote_service.dart';

class MockAuthenticatedHttpClient extends Mock implements AuthenticatedHttpClient {}

void main() {
  late MockAuthenticatedHttpClient client;
  const date = '2026-05-23T10:00:00.000Z';
  const complexJson = {
    'id': 10,
    'complexName': 'Center',
    'timeIni': '08:00',
    'timeEnd': '22:00',
    'locLatitude': null,
    'locLongitude': null,
    'sports': ['padel'],
    'createdAt': date,
    'updatedAt': date,
  };
  const courtJson = {
    'id': 2,
    'complexId': 10,
    'sport': 'padel',
    'name': 'Court',
    'description': 'Indoor',
    'maxPeople': 4,
    'status': 'open',
    'createdAt': date,
    'updatedAt': date,
  };
  const reservationJson = {
    'id': 3,
    'userId': 6,
    'complexId': 10,
    'courtId': 2,
    'dateIni': date,
    'dateEnd': '2026-05-23T11:00:00.000Z',
    'status': 'occupied',
    'reservationStatus': 'scheduled',
    'timeFilter': 'upcoming',
    'createdAt': date,
    'updatedAt': date,
  };

  setUpAll(() {
    registerFallbackValue(Uri.parse('http://example.test'));
  });

  setUp(() {
    client = MockAuthenticatedHttpClient();
  });

  test('complexes filters invalid query values and maps response DTOs', () async {
    when(() => client.get(any())).thenAnswer((_) async => http.Response(jsonEncode([complexJson]), 200));
    final service = ComplexesRemoteServiceImpl(client: client);

    final result = await service.getComplexes({'id': '10', 'locLatitude': 'invalid', 'other': 'discard'});

    expect((result as Ok).value.single.name, equals('Center'));
    final requestedUri = verify(() => client.get(captureAny())).captured.single as Uri;
    expect(requestedUri.queryParameters, equals({'id': '10'}));
  });

  test('complexes maps individual resources and failed or thrown requests', () async {
    final service = ComplexesRemoteServiceImpl(client: client);
    when(() => client.get(any())).thenAnswer((_) async => http.Response(jsonEncode(complexJson), 200));

    final success = await service.getComplex(10);

    expect((success as Ok).value.id, equals(10));

    when(() => client.get(any())).thenAnswer((_) async => http.Response(jsonEncode({'message': 'missing'}), 404));
    expect(((await service.getComplexes(null) as Error).error as NetworkException).message, equals('missing'));
    expect(((await service.getComplex(10) as Error).error as NetworkException).message, equals('missing'));

    final failure = Exception('request failed');
    when(() => client.get(any())).thenThrow(failure);
    expect((await service.getComplexes(null) as Error).error, same(failure));
    expect((await service.getComplex(10) as Error).error, same(failure));
  });

  test('courts filters queries and maps list responses', () async {
    when(() => client.get(any())).thenAnswer((_) async => http.Response(jsonEncode([courtJson]), 200));
    final service = CourtsRemoteServiceImpl(client: client);

    final result = await service.getCourts(10, {'sport': 'padel', 'maxPeople': '4', 'unknown': 1});

    expect((result as Ok).value.single.name, equals('Court'));
    final uri = verify(() => client.get(captureAny())).captured.single as Uri;
    expect(uri.queryParameters, equals({'sport': 'padel', 'maxPeople': '4'}));
  });

  test('courts maps an individual court and availability endpoint response', () async {
    const availabilityJson = {'id': 2, 'complexId': 10, 'availability': <Object>[]};
    when(() => client.get(any())).thenAnswer((invocation) async {
      final uri = invocation.positionalArguments.single as Uri;
      return uri.path.endsWith('/availability')
          ? http.Response(jsonEncode(availabilityJson), 200)
          : http.Response(jsonEncode(courtJson), 200);
    });
    final service = CourtsRemoteServiceImpl(client: client);

    final courtResult = await service.getCourt(10, 2);
    final availabilityResult = await service.getCourtAvailability(10, 2);

    expect((courtResult as Ok).value.id, equals(2));
    expect((availabilityResult as Ok).value.availability, isEmpty);
  });

  test('courts maps failed and thrown requests for each endpoint', () async {
    final service = CourtsRemoteServiceImpl(client: client);
    when(() => client.get(any())).thenAnswer((_) async => http.Response(jsonEncode({'message': 'closed'}), 404));

    expect(((await service.getCourts(10, null) as Error).error as NetworkException).message, equals('closed'));
    expect(((await service.getCourt(10, 2) as Error).error as NetworkException).message, equals('closed'));
    expect(((await service.getCourtAvailability(10, 2) as Error).error as NetworkException).message, equals('closed'));

    final failure = Exception('request failed');
    when(() => client.get(any())).thenThrow(failure);
    expect((await service.getCourts(10, null) as Error).error, same(failure));
    expect((await service.getCourt(10, 2) as Error).error, same(failure));
    expect((await service.getCourtAvailability(10, 2) as Error).error, same(failure));
  });

  test('reservations includes valid filters and returns server messages on failure', () async {
    final service = ReservationsRemoteServiceImpl(client: client);
    when(() => client.get(any())).thenAnswer((_) async => http.Response(jsonEncode([reservationJson]), 200));

    final success = await service.getUserReservations(6, {'timeFilter': 'upcoming', 'courtId': false});

    expect((success as Ok).value.single.userId, equals(6));
    final requestedUri = verify(() => client.get(captureAny())).captured.single as Uri;
    expect(requestedUri.queryParameters, equals({'timeFilter': 'upcoming'}));

    when(() => client.get(any())).thenAnswer((_) async => http.Response(jsonEncode({'message': 'denied'}), 403));
    final failure = await service.getUserReservations(6, null);

    switch (failure) {
      case Error(:final error):
        expect(error, isA<NetworkException>());
        expect((error as NetworkException).message, equals('denied'));
      case Ok():
        fail('Expected a network error response.');
    }
  });

  test('reservations returns thrown client errors', () async {
    final failure = Exception('request failed');
    when(() => client.get(any())).thenThrow(failure);

    final result = await ReservationsRemoteServiceImpl(client: client).getUserReservations(6, null);

    expect((result as Error).error, same(failure));
  });
}

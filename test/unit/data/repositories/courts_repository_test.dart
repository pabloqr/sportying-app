import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/courts/courts_repository.dart';
import 'package:sportying_app/data/services/remote/courts/courts_remote_service.dart';
import 'package:sportying_app/data/services/remote/courts/models/court_availability_dto.dart';
import 'package:sportying_app/data/services/remote/courts/models/court_dto.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_availability.dart';
import 'package:sportying_app/domain/models/courts/court_status.dart';

class MockCourtsRemoteService extends Mock implements CourtsRemoteService {}

void main() {
  late MockCourtsRemoteService remoteService;
  late CourtsRepositoryImpl repository;

  setUp(() {
    remoteService = MockCourtsRemoteService();
    repository = CourtsRepositoryImpl(remoteService: remoteService);
  });

  final now = DateTime.now();
  final complex = Complex(
    id: 10,
    name: 'Complex 10',
    timeIni: '08:00',
    timeEnd: '22:00',
    address: 'Madrid, Spain',
    locLatitude: 40.0,
    locLongitude: -3.0,
    sports: {Sport.football},
    createdAt: now,
    updatedAt: now,
  );

  final courtDto = CourtDto(
    id: 1,
    complexId: 10,
    sport: 'football',
    name: 'Court 1',
    description: 'Desc',
    maxPeople: 10,
    status: 'open',
    createdAt: now,
    updatedAt: now,
  );

  final courtDomain = Court(
    id: 1,
    complex: complex,
    sport: Sport.football,
    name: 'Court 1',
    description: 'Desc',
    maxPeople: 10,
    status: CourtStatus.open,
    createdAt: now,
    updatedAt: now,
  );

  group('CourtsRepositoryImpl Tests', () {
    test('getCourts success returns list of mapped courts', () async {
      when(() => remoteService.getCourts(any(), any())).thenAnswer((_) async => Result.ok([courtDto]));

      final result = await repository.getCourts(complex);

      expect(result, isA<Ok<List<Court>>>());
      final list = (result as Ok<List<Court>>).value;
      expect(list.length, equals(1));
      expect(list[0].id, equals(1));
      expect(list[0].complex, equals(complex));

      verify(() => remoteService.getCourts(10, null)).called(1);
    });

    test('getCourts failure returns error', () async {
      final exception = Exception('Error fetching courts');
      when(() => remoteService.getCourts(any(), any())).thenAnswer((_) async => Result.error(exception));

      final result = await repository.getCourts(complex);

      expect(result, isA<Error<List<Court>>>());
      expect((result as Error).error, equals(exception));
    });

    test('getCourts converts thrown remote failures to results', () async {
      final exception = Exception('Remote threw');
      when(() => remoteService.getCourts(any(), any())).thenThrow(exception);

      final result = await repository.getCourts(complex);

      expect((result as Error<List<Court>>).error, same(exception));
    });

    test('getCourtAvailability success returns mapped availability', () async {
      final availabilityDto = CourtAvailabilityDto(
        id: 1,
        complexId: 10,
        availability: [
          CourtAvailabilitySlotDto(dateIni: now, dateEnd: now.add(const Duration(hours: 1)), available: true),
        ],
      );

      when(() => remoteService.getCourtAvailability(any(), any())).thenAnswer((_) async => Result.ok(availabilityDto));

      final result = await repository.getCourtAvailability(complex, courtDomain);

      expect(result, isA<Ok<CourtAvailability>>());
      final domain = (result as Ok<CourtAvailability>).value;
      expect(domain.court, equals(courtDomain));
      expect(domain.complex, equals(complex));
      expect(domain.availability.length, equals(1));
      expect(domain.availability[0].available, isTrue);

      verify(() => remoteService.getCourtAvailability(10, 1)).called(1);
    });

    test('getCourtAvailability failure returns error', () async {
      final exception = Exception('Error fetching availability');
      when(() => remoteService.getCourtAvailability(any(), any())).thenAnswer((_) async => Result.error(exception));

      final result = await repository.getCourtAvailability(complex, courtDomain);

      expect(result, isA<Error<CourtAvailability>>());
      expect((result as Error).error, equals(exception));
    });

    test('getCourtAvailability converts thrown remote failures to results', () async {
      final exception = Exception('Remote threw');
      when(() => remoteService.getCourtAvailability(any(), any())).thenThrow(exception);

      final result = await repository.getCourtAvailability(complex, courtDomain);

      expect((result as Error<CourtAvailability>).error, same(exception));
    });
  });
}

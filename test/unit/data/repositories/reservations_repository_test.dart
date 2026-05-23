import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/reservations/reservations_repository.dart';
import 'package:sportying_app/data/services/remote/complexes/complexes_remote_service.dart';
import 'package:sportying_app/data/services/remote/complexes/models/complex_dto.dart';
import 'package:sportying_app/data/services/remote/courts/courts_remote_service.dart';
import 'package:sportying_app/data/services/remote/courts/models/court_dto.dart';
import 'package:sportying_app/data/services/remote/reservations/models/reservation_dto.dart';
import 'package:sportying_app/data/services/remote/reservations/reservations_remote_service.dart';
import 'package:sportying_app/domain/models/reservations/availability_status.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/domain/models/reservations/time_filter.dart';

class MockReservationsRemoteService extends Mock implements ReservationsRemoteService {}

class MockComplexesRemoteService extends Mock implements ComplexesRemoteService {}

class MockCourtsRemoteService extends Mock implements CourtsRemoteService {}

void main() {
  late MockReservationsRemoteService remoteService;
  late MockComplexesRemoteService complexesRemoteService;
  late MockCourtsRemoteService courtsRemoteService;
  late ReservationsRepositoryImpl repository;

  setUp(() {
    remoteService = MockReservationsRemoteService();
    complexesRemoteService = MockComplexesRemoteService();
    courtsRemoteService = MockCourtsRemoteService();
    repository = ReservationsRepositoryImpl(
      remoteService: remoteService,
      complexesRemoteService: complexesRemoteService,
      courtsRemoteService: courtsRemoteService,
    );
  });

  final now = DateTime.now();

  final reservationDto = ReservationDto(
    id: 100,
    userId: 5,
    complexId: 10,
    courtId: 1,
    dateIni: now,
    dateEnd: now.add(const Duration(hours: 1)),
    status: 'occupied',
    reservationStatus: 'scheduled',
    timeFilter: 'upcoming',
    createdAt: now,
    updatedAt: now,
  );

  final complexDto = ComplexDto(
    id: 10,
    name: 'Complex 10',
    timeIni: '08:00',
    timeEnd: '22:00',
    locLatitude: 40.0,
    locLongitude: -3.0,
    sports: ['football'],
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

  group('ReservationsRepositoryImpl Tests', () {
    test(
      'getUserReservations success fetches remote reservations, complexes, courts, and maps nested domain objects',
      () async {
        when(
          () => remoteService.getUserReservations(any(), any()),
        ).thenAnswer((_) async => Result.ok([reservationDto]));
        when(() => complexesRemoteService.getComplex(any())).thenAnswer((_) async => Result.ok(complexDto));
        when(() => courtsRemoteService.getCourt(any(), any())).thenAnswer((_) async => Result.ok(courtDto));

        final result = await repository.getUserReservations(5);

        expect(result, isA<Ok<List<Reservation>>>());
        final list = (result as Ok<List<Reservation>>).value;
        expect(list.length, equals(1));

        final res = list[0];
        expect(res.id, equals(100));
        expect(res.userId, equals(5));
        expect(res.status, equals(AvailabilityStatus.occupied));
        expect(res.reservationStatus, equals(ReservationStatus.scheduled));
        expect(res.timeFilter, equals(TimeFilter.upcoming));

        expect(res.complex.id, equals(10));
        expect(res.complex.name, equals('Complex 10'));
        expect(res.complex.address, equals('No address provided'));

        expect(res.court.id, equals(1));
        expect(res.court.name, equals('Court 1'));

        verify(() => remoteService.getUserReservations(5, null)).called(1);
        verify(() => complexesRemoteService.getComplex(10)).called(1);
        verify(() => courtsRemoteService.getCourt(10, 1)).called(1);
      },
    );

    test('getUserReservations failure returns remote reservations error', () async {
      final exception = Exception('Reservations fetch failed');
      when(() => remoteService.getUserReservations(any(), any())).thenAnswer((_) async => Result.error(exception));

      final result = await repository.getUserReservations(5);

      expect(result, isA<Error<List<Reservation>>>());
      expect((result as Error).error, equals(exception));

      verify(() => remoteService.getUserReservations(5, null)).called(1);
      verifyNoMoreInteractions(complexesRemoteService);
      verifyNoMoreInteractions(courtsRemoteService);
    });

    test('getUserReservations fails when complexesRemoteService returns error', () async {
      final exception = Exception('Complex fetch failed');
      when(() => remoteService.getUserReservations(any(), any())).thenAnswer((_) async => Result.ok([reservationDto]));
      when(() => complexesRemoteService.getComplex(any())).thenAnswer((_) async => Result.error(exception));

      final result = await repository.getUserReservations(5);

      expect(result, isA<Error<List<Reservation>>>());
      expect((result as Error).error, equals(exception));

      verify(() => remoteService.getUserReservations(5, null)).called(1);
      verify(() => complexesRemoteService.getComplex(10)).called(1);
      verifyNoMoreInteractions(courtsRemoteService);
    });

    test('getUserReservations fails when courtsRemoteService returns error', () async {
      final exception = Exception('Court fetch failed');
      when(() => remoteService.getUserReservations(any(), any())).thenAnswer((_) async => Result.ok([reservationDto]));
      when(() => complexesRemoteService.getComplex(any())).thenAnswer((_) async => Result.ok(complexDto));
      when(() => courtsRemoteService.getCourt(any(), any())).thenAnswer((_) async => Result.error(exception));

      final result = await repository.getUserReservations(5);

      expect((result as Error<List<Reservation>>).error, same(exception));
      verify(() => courtsRemoteService.getCourt(10, 1)).called(1);
    });
  });
}

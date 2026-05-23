import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/complexes/complexes_repository.dart';
import 'package:sportying_app/data/repositories/reservations/reservations_repository.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_status.dart';
import 'package:sportying_app/domain/models/reservations/availability_status.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/domain/models/reservations/time_filter.dart';
import 'package:sportying_app/features/users/clients/home/view_model/client_home_viewmodel.dart';

class MockReservationsRepository extends Mock implements ReservationsRepository {}

class MockComplexesRepository extends Mock implements ComplexesRepository {}

void main() {
  late MockReservationsRepository reservationsRepository;
  late MockComplexesRepository complexesRepository;
  final now = DateTime.now();

  final complex = Complex(
    id: 1,
    name: 'Complex 1',
    timeIni: '08:00',
    timeEnd: '22:00',
    address: 'Madrid, Spain',
    locLatitude: 40.0,
    locLongitude: -3.0,
    sports: {Sport.football},
    createdAt: now,
    updatedAt: now,
  );

  final court = Court(
    id: 2,
    complex: complex,
    sport: Sport.football,
    name: 'Court 2',
    description: 'Main Court',
    maxPeople: 10,
    status: CourtStatus.open,
    createdAt: now,
    updatedAt: now,
  );

  // Past reservation (should be filtered out of upcoming selection)
  final pastReservation = Reservation(
    id: 101,
    userId: 6,
    complex: complex,
    court: court,
    dateIni: now.subtract(const Duration(days: 1)),
    dateEnd: now.subtract(const Duration(days: 1, hours: -1)),
    status: AvailabilityStatus.occupied,
    reservationStatus: ReservationStatus.completed,
    timeFilter: TimeFilter.past,
    createdAt: now,
    updatedAt: now,
  );

  // Upcoming reservation 2 (further in future)
  final upcomingReservationFar = Reservation(
    id: 103,
    userId: 6,
    complex: complex,
    court: court,
    dateIni: now.add(const Duration(days: 2)),
    dateEnd: now.add(const Duration(days: 2, hours: 1)),
    status: AvailabilityStatus.occupied,
    reservationStatus: ReservationStatus.scheduled,
    timeFilter: TimeFilter.upcoming,
    createdAt: now,
    updatedAt: now,
  );

  // Upcoming reservation 1 (closer in future)
  final upcomingReservationNear = Reservation(
    id: 102,
    userId: 6,
    complex: complex,
    court: court,
    dateIni: now.add(const Duration(days: 1)),
    dateEnd: now.add(const Duration(days: 1, hours: 1)),
    status: AvailabilityStatus.occupied,
    reservationStatus: ReservationStatus.scheduled,
    timeFilter: TimeFilter.upcoming,
    createdAt: now,
    updatedAt: now,
  );

  setUp(() {
    reservationsRepository = MockReservationsRepository();
    complexesRepository = MockComplexesRepository();
  });

  group('ClientHomeViewModel Tests', () {
    test('Constructor loads reservations and complexes, selecting closest upcoming reservation', () async {
      when(
        () => reservationsRepository.getUserReservations(any(), query: any(named: 'query')),
      ).thenAnswer((_) async => Result.ok([pastReservation, upcomingReservationFar, upcomingReservationNear]));
      when(
        () => complexesRepository.getComplexes(query: any(named: 'query')),
      ).thenAnswer((_) async => Result.ok([complex]));

      final viewModel = ClientHomeViewModel(
        reservationRepository: reservationsRepository,
        complexesRepository: complexesRepository,
      );

      // Wait for constructor load to complete
      while (viewModel.load.running) {
        await Future<void>.delayed(Duration.zero);
      }

      // Verify closest upcoming reservation selected
      expect(viewModel.reservation, equals(upcomingReservationNear));
      expect(viewModel.complexes.length, equals(1));
      expect(viewModel.complexes[0], equals(complex));

      verify(() => reservationsRepository.getUserReservations(6, query: any(named: 'query'))).called(1);
      verify(() => complexesRepository.getComplexes(query: any(named: 'query'))).called(1);
    });

    test('Loads successfully even if there are no upcoming reservations', () async {
      when(
        () => reservationsRepository.getUserReservations(any(), query: any(named: 'query')),
      ).thenAnswer((_) async => Result.ok([pastReservation]));
      when(
        () => complexesRepository.getComplexes(query: any(named: 'query')),
      ).thenAnswer((_) async => Result.ok([complex]));

      final viewModel = ClientHomeViewModel(
        reservationRepository: reservationsRepository,
        complexesRepository: complexesRepository,
      );

      while (viewModel.load.running) {
        await Future<void>.delayed(Duration.zero);
      }

      expect(viewModel.reservation, isNull);
      expect(viewModel.complexes.length, equals(1));
    });

    test('Handles reservation repo error gracefully and executes complexes fetch', () async {
      final exception = Exception('Error fetching reservations');
      when(
        () => reservationsRepository.getUserReservations(any(), query: any(named: 'query')),
      ).thenAnswer((_) async => Result.error(exception));
      when(
        () => complexesRepository.getComplexes(query: any(named: 'query')),
      ).thenAnswer((_) async => Result.ok([complex]));

      final viewModel = ClientHomeViewModel(
        reservationRepository: reservationsRepository,
        complexesRepository: complexesRepository,
      );

      while (viewModel.load.running) {
        await Future<void>.delayed(Duration.zero);
      }

      expect(viewModel.reservation, isNull);
      expect(viewModel.load.error, isTrue); // Main command reflects the error returned by the function
    });

    test('Completes with an error when complexes cannot be loaded', () async {
      final exception = Exception('Error fetching complexes');
      when(
        () => reservationsRepository.getUserReservations(any(), query: any(named: 'query')),
      ).thenAnswer((_) async => Result.ok([upcomingReservationNear]));
      when(
        () => complexesRepository.getComplexes(query: any(named: 'query')),
      ).thenAnswer((_) async => Result.error(exception));

      final viewModel = ClientHomeViewModel(
        reservationRepository: reservationsRepository,
        complexesRepository: complexesRepository,
      );

      while (viewModel.load.running) {
        await Future<void>.delayed(Duration.zero);
      }

      expect(viewModel.reservation, equals(upcomingReservationNear));
      expect(viewModel.complexes, isEmpty);
      expect(viewModel.load.error, isTrue);
      expect((viewModel.load.result! as Error<void>).error, same(exception));
    });
  });
}

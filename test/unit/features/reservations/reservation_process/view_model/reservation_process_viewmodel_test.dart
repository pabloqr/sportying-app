import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/complexes/complexes_repository.dart';
import 'package:sportying_app/data/repositories/courts/courts_repository.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_availability.dart';
import 'package:sportying_app/domain/models/courts/court_status.dart';
import 'package:sportying_app/features/reservations/reservation_process/view_model/reservation_process_viewmodel.dart';

class MockComplexesRepository extends Mock implements ComplexesRepository {}

class MockCourtsRepository extends Mock implements CourtsRepository {}

Future<void> waitForComplexes(ReservationProcessViewModel viewModel) async {
  while (viewModel.loadComplexes.running) {
    await Future<void>.delayed(Duration.zero);
  }
}

void main() {
  late MockComplexesRepository complexesRepository;
  late MockCourtsRepository courtsRepository;
  final now = DateTime.utc(2026, 5, 23);
  final complex = Complex(
    id: 1,
    name: 'Center',
    timeIni: '08:00',
    timeEnd: '22:00',
    address: 'Madrid',
    locLatitude: 40,
    locLongitude: -3,
    sports: {Sport.padel},
    createdAt: now,
    updatedAt: now,
  );
  late Court court;
  late CourtAvailability availability;

  setUp(() {
    complexesRepository = MockComplexesRepository();
    courtsRepository = MockCourtsRepository();
    court = Court(
      id: 2,
      complex: complex,
      sport: Sport.padel,
      name: 'Court',
      description: 'Indoor',
      maxPeople: 4,
      status: CourtStatus.open,
      createdAt: now,
      updatedAt: now,
    );
    availability = CourtAvailability(complex: complex, court: court, availability: [], nextAvailable: now);
    when(() => complexesRepository.getComplexes()).thenAnswer((_) async => Result.ok([complex]));
  });

  test('constructor loads complexes', () async {
    final viewModel = ReservationProcessViewModel(
      complexesRepository: complexesRepository,
      courtsRepository: courtsRepository,
    );
    await waitForComplexes(viewModel);

    expect(viewModel.loadComplexes.completed, isTrue);
    expect(viewModel.complexes, equals([complex]));
  });

  test('constructor exposes a complexes loading failure', () async {
    reset(complexesRepository);
    when(() => complexesRepository.getComplexes()).thenAnswer((_) async => Result.error(Exception('failed')));

    final viewModel = ReservationProcessViewModel(
      complexesRepository: complexesRepository,
      courtsRepository: courtsRepository,
    );
    await waitForComplexes(viewModel);

    expect(viewModel.complexes, isEmpty);
    expect(viewModel.loadComplexes.error, isTrue);
  });

  test('loadCourts loads selected sport courts and each available schedule', () async {
    when(
      () => courtsRepository.getCourts(complex, query: {'sport': 'PADEL'}),
    ).thenAnswer((_) async => Result.ok([court]));
    when(() => courtsRepository.getCourtAvailability(complex, court)).thenAnswer((_) async => Result.ok(availability));
    final viewModel = ReservationProcessViewModel(
      complexesRepository: complexesRepository,
      courtsRepository: courtsRepository,
    );
    await waitForComplexes(viewModel);

    await viewModel.loadCourts.execute(complex, Sport.padel);

    expect(viewModel.loadCourts.completed, isTrue);
    expect(viewModel.courts, equals([court]));
    expect(viewModel.courtsAvailability, containsPair(court.id, availability));
    verify(() => courtsRepository.getCourts(complex, query: {'sport': 'PADEL'})).called(1);
    verify(() => courtsRepository.getCourtAvailability(complex, court)).called(1);
  });

  test('loadCourts keeps successful courts when individual availability fails', () async {
    when(
      () => courtsRepository.getCourts(complex, query: {'sport': 'PADEL'}),
    ).thenAnswer((_) async => Result.ok([court]));
    when(
      () => courtsRepository.getCourtAvailability(complex, court),
    ).thenAnswer((_) async => Result.error(Exception('unavailable')));
    final viewModel = ReservationProcessViewModel(
      complexesRepository: complexesRepository,
      courtsRepository: courtsRepository,
    );
    await waitForComplexes(viewModel);

    await viewModel.loadCourts.execute(complex, Sport.padel);

    expect(viewModel.loadCourts.completed, isTrue);
    expect(viewModel.courts, equals([court]));
    expect(viewModel.courtsAvailability, isEmpty);
  });

  test('loadCourts exposes court loading failures without fetching availability', () async {
    when(
      () => courtsRepository.getCourts(complex, query: {'sport': 'PADEL'}),
    ).thenAnswer((_) async => Result.error(Exception('failed')));
    final viewModel = ReservationProcessViewModel(
      complexesRepository: complexesRepository,
      courtsRepository: courtsRepository,
    );
    await waitForComplexes(viewModel);

    await viewModel.loadCourts.execute(complex, Sport.padel);

    expect(viewModel.loadCourts.error, isTrue);
    expect(viewModel.courts, isEmpty);
    verifyNever(() => courtsRepository.getCourtAvailability(complex, court));
  });
}

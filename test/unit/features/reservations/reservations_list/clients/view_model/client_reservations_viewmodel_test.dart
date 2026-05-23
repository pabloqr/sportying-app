import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/reservations/reservations_repository.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_status.dart';
import 'package:sportying_app/domain/models/reservations/availability_status.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/domain/models/reservations/time_filter.dart';
import 'package:sportying_app/features/reservations/reservations_list/clients/view_model/client_reservations_viewmodel.dart';

class MockReservationsRepository extends Mock implements ReservationsRepository {}

Future<void> waitForLoad(ClientReservationsViewModel viewModel) async {
  while (viewModel.load.running) {
    await Future<void>.delayed(Duration.zero);
  }
}

void main() {
  late MockReservationsRepository repository;
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
  late Reservation reservation;

  setUp(() {
    repository = MockReservationsRepository();
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
    reservation = Reservation(
      id: 3,
      userId: 6,
      complex: complex,
      court: court,
      dateIni: now,
      dateEnd: now.add(const Duration(hours: 1)),
      status: AvailabilityStatus.occupied,
      reservationStatus: ReservationStatus.scheduled,
      timeFilter: TimeFilter.upcoming,
      createdAt: now,
      updatedAt: now,
    );
  });

  test('constructor loads user reservations into immutable exposed state', () async {
    when(() => repository.getUserReservations(6)).thenAnswer((_) async => Result.ok([reservation]));

    final viewModel = ClientReservationsViewModel(reservationRepository: repository);
    await waitForLoad(viewModel);

    expect(viewModel.load.completed, isTrue);
    expect(viewModel.reservations, equals([reservation]));
    expect(() => viewModel.reservations.add(reservation), throwsUnsupportedError);
    verify(() => repository.getUserReservations(6)).called(1);
  });

  test('constructor exposes repository failure through its command', () async {
    final failure = Exception('failed');
    when(() => repository.getUserReservations(6)).thenAnswer((_) async => Result.error(failure));

    final viewModel = ClientReservationsViewModel(reservationRepository: repository);
    await waitForLoad(viewModel);

    expect(viewModel.reservations, isEmpty);
    expect(viewModel.load.error, isTrue);
    expect((viewModel.load.result! as Error<void>).error, same(failure));
  });
}

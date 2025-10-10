import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:sportying_app/core/utils/command.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/complexes/complexes_repository.dart';
import 'package:sportying_app/data/repositories/reservations/reservations_repository.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/domain/models/reservations/time_filter.dart';

class ClientHomeViewModel extends ChangeNotifier {
  final _log = Logger('ClientDashboardViewModel');

  ClientHomeViewModel({
    required ReservationsRepository reservationRepository,
    required ComplexesRepository complexesRepository,
  }) : _reservationsRepository = reservationRepository,
       _complexesRepository = complexesRepository {
    load = Command1(_load)..execute(6);
  }

  final ReservationsRepository _reservationsRepository;
  final ComplexesRepository _complexesRepository;

  Reservation? _reservation;
  Reservation? get reservation => _reservation;

  List<Complex> _complexes = [];
  UnmodifiableListView<Complex> get complexes => UnmodifiableListView(_complexes);

  late Command1<void, int> load;

  Future<Result> _load(int userId) async {
    final reservationsResult = await _reservationsRepository.getUserReservations(userId);
    switch (reservationsResult) {
      case Ok<List<Reservation>>():
        _log.fine('Loaded reservations. Getting next upcoming reservation.');

        final reservations = reservationsResult.value
            .where((reservation) => reservation.timeFilter == TimeFilter.upcoming)
            .toList();

        if (reservations.isNotEmpty) {
          reservations.sort((a, b) => a.dateIni.compareTo(b.dateIni));
          _reservation = reservations.first;
        }

        notifyListeners();
        break;
      case Error<List<Reservation>>():
        _log.warning('Failed to load reservations.');
        return Result.error(reservationsResult.error);
    }

    final complexesResult = await _complexesRepository.getComplexes();
    switch (complexesResult) {
      case Ok<List<Complex>>():
        _log.fine('Loaded complexes.');

        _complexes = complexesResult.value;
        notifyListeners();
        break;
      case Error<List<Complex>>():
        _log.warning('Failed to load complexes.');
        break;
    }

    return complexesResult;
  }
}

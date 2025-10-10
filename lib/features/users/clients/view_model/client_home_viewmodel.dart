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
    // Obtener las reservas del usuario
    final reservationsResult = await _reservationsRepository.getUserReservations(userId);
    // Obtener el resultado de la operación
    switch (reservationsResult) {
      case Ok<List<Reservation>>():
        _log.fine('Loaded reservations. Getting next upcoming reservation.');

        // Filtrar las reservas para seleccionar sólo las próximas
        final reservations = reservationsResult.value
            .where((reservation) => reservation.timeFilter == TimeFilter.upcoming)
            .toList();

        // Verificar que hay reservas
        if (reservations.isNotEmpty) {
          // Ordenar de más cercana a más lejana en el tiempo
          reservations.sort((a, b) => a.dateIni.compareTo(b.dateIni));
          // Actualizar la reserva almacenada en la memoria de la aplicación
          _reservation = reservations.first;
        }

        notifyListeners();
        break;
      case Error<List<Reservation>>():
        _log.warning('Failed to load reservations.');
        return Result.error(reservationsResult.error);
    }

    // Obtener los complejos almacenados en el sistema
    final complexesResult = await _complexesRepository.getComplexes();
    // Obtener el resultado de la operación
    switch (complexesResult) {
      case Ok<List<Complex>>():
        _log.fine('Loaded complexes.');

        // Actualizar la lista de complejos almacenados en el sistema
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

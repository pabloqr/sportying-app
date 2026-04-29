import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:sportying_app/core/utils/command.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/reservations/reservations_repository.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';

class ClientReservationsViewModel extends ChangeNotifier {
  final _log = Logger('ClientReservationsViewModel');

  ClientReservationsViewModel({required ReservationsRepository reservationRepository})
    : _reservationsRepository = reservationRepository {
    load = Command1(_load)..execute(6);
  }

  final ReservationsRepository _reservationsRepository;

  List<Reservation> _reservations = [];
  UnmodifiableListView<Reservation> get reservations => UnmodifiableListView(_reservations);

  late Command1<void, int> load;

  Future<Result> _load(int userId) async {
    // Obtener las reservas del usuario
    final reservationsResult = await _reservationsRepository.getUserReservations(userId);
    // Obtener el resultado de la operación
    switch (reservationsResult) {
      case Ok<List<Reservation>>():
        _log.fine('Loaded reservations. Getting next upcoming reservation.');

        // Actualizar la lista de reservas almacenadas en el sistema
        _reservations = reservationsResult.value;
        notifyListeners();
        break;
      case Error<List<Reservation>>():
        _log.warning('Failed to load reservations.');
        return Result.error(reservationsResult.error);
    }

    return reservationsResult;
  }
}

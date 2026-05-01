import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:sportying_app/core/utils/command.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/complexes/complexes_repository.dart';
import 'package:sportying_app/data/repositories/courts/courts_repository.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_availability.dart';

class ReservationProcessViewModel extends ChangeNotifier {
  final _log = Logger('ReservationProcessViewmodel');

  ReservationProcessViewModel({
    required ComplexesRepository complexesRepository,
    required CourtsRepository courtsRepository,
  }) : _complexesRepository = complexesRepository,
       _courtsRepository = courtsRepository {
    loadComplexes = Command0(_loadComplexes)..execute();
    loadCourts = Command2(_loadCourts);
  }

  final ComplexesRepository _complexesRepository;
  final CourtsRepository _courtsRepository;

  List<Complex> _complexes = [];
  UnmodifiableListView<Complex> get complexes => UnmodifiableListView(_complexes);

  List<Court> _courts = [];
  UnmodifiableListView<Court> get courts => UnmodifiableListView(_courts);

  final Map<int, CourtAvailability> _courtsAvailability = {};
  UnmodifiableMapView<int, CourtAvailability> get courtsAvailability => UnmodifiableMapView(_courtsAvailability);

  late Command0<void> loadComplexes;
  late Command2<void, Complex, Sport> loadCourts;

  Future<Result> _loadComplexes() async {
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

  Future<Result> _loadCourts(Complex complex, Sport sport) async {
    // Obtener las pistas almacenadas en el sistema
    final courtsResult = await _courtsRepository.getCourts(complex, query: {'sport': sport.name.toUpperCase()});
    // Obtener el resultado de la operación
    switch (courtsResult) {
      case Ok<List<Court>>():
        _log.fine('Loaded courts.');

        // Actualizar la lista de pistas almacenadas en el sistema
        _courts = courtsResult.value;

        // Obtener la disponibilidad de cada una de las pistas obtenidas
        for (final court in _courts) {
          final availabilityResult = await _courtsRepository.getCourtAvailability(complex, court);
          switch (availabilityResult) {
            case Ok<CourtAvailability>():
              _log.fine('Loaded court (${court.id}) availability.');

              _courtsAvailability[court.id] = availabilityResult.value;
              break;
            case Error<CourtAvailability>():
              _log.warning('Failed to load court (${court.id}) availability.');
              break;
          }
        }

        notifyListeners();
        break;
      case Error<List<Court>>():
        _log.warning('Failed to load courts.');
        break;
    }

    return courtsResult;
  }
}

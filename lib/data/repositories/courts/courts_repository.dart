import 'package:logging/logging.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/courts/courts_remote_service.dart';
import 'package:sportying_app/data/services/courts/models/court_api_model.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_status.dart';

abstract class CourtsRepository {
  Future<Result<List<Court>>> getCourts(Complex complex, {Map<String, dynamic>? query});
  // Future<Result<Court>> getCourt(int complexId, int courtId);
}

class CourtsRepositoryImpl implements CourtsRepository {
  final _log = Logger('CourtsRepository');

  CourtsRepositoryImpl({required CourtsRemoteService remoteService}) : _remoteService = remoteService;

  final CourtsRemoteService _remoteService;

  @override
  Future<Result<List<Court>>> getCourts(Complex complex, {Map<String, dynamic>? query}) async {
    try {
      // Obtener las pistas almacenadas en el sistema para el complejo dado
      // TODO: optimización para obtener solo las más relevantes y paginación
      final result = await _remoteService.getCourts(complex.id, query);
      // Obtener el resultado de la operación
      switch (result) {
        case Ok<List<CourtApiModel>>():
          _log.fine('Fetched complexes from server. Getting nested information.');

          return Result.ok(
            // Necesario para las operaciones asíncronas que se realizan dentro del bucle
            await Future.wait(
              // Procesar todos las pistas obtenidas para transformarlas al modelo que emplea la aplicación
              result.value.map((court) async {
                _log.fine('Fetched nested information.');

                // Crear la instancia del modelo de la pista
                return Court(
                  id: court.id ?? 0,
                  complex: complex,
                  sport: Sport.values.byName(court.sport.toLowerCase()),
                  name: court.name,
                  description: court.description,
                  maxPeople: court.maxPeople,
                  status: CourtStatus.values.byName(court.status.toLowerCase()),
                  createdAt: court.createdAt,
                  updatedAt: court.updatedAt,
                );
              }),
            ),
          );
        case Error<List<CourtApiModel>>():
          _log.warning('Failed to fetch nested information.');
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      _log.warning('Failed to fetch complexes.');
      return Result.error(e);
    }
  }
}

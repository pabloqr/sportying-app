import 'package:logging/logging.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/mappers/court_availability_mapper.dart';
import 'package:sportying_app/data/mappers/court_mapper.dart';
import 'package:sportying_app/data/services/remote/courts/courts_remote_service.dart';
import 'package:sportying_app/data/services/remote/courts/models/court_availability_dto.dart';
import 'package:sportying_app/data/services/remote/courts/models/court_dto.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_availability.dart';

abstract class CourtsRepository {
  Future<Result<List<Court>>> getCourts(Complex complex, {Map<String, dynamic>? query});
  // Future<Result<Court>> getCourt(int complexId, int courtId);

  Future<Result<CourtAvailability>> getCourtAvailability(Complex complex, Court court);
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
        case Ok<List<CourtDto>>():
          _log.fine('Fetched complexes from server. Getting nested information.');

          return Result.ok(
            // Necesario para las operaciones asíncronas que se realizan dentro del bucle
            await Future.wait(
              // Procesar todos las pistas obtenidas para transformarlas al modelo que emplea la aplicación
              result.value.map((court) async {
                _log.fine('Fetched nested information.');

                // Crear la instancia del modelo de la pista
                return court.toDomain(complex);
              }),
            ),
          );
        case Error<List<CourtDto>>():
          _log.warning('Failed to fetch nested information.');
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      _log.warning('Failed to fetch complexes.');
      return Result.error(e);
    }
  }

  @override
  Future<Result<CourtAvailability>> getCourtAvailability(Complex complex, Court court) async {
    try {
      // Obtener las pistas almacenadas en el sistema para el complejo dado
      // TODO: optimización para obtener solo las más relevantes y paginación
      final result = await _remoteService.getCourtAvailability(complex.id, court.id);
      // Obtener el resultado de la operación
      switch (result) {
        case Ok<CourtAvailabilityDto>():
          _log.fine('Fetched complexes from server. Getting nested information.');

          // Crear la instancia del modelo de la disponibilidad
          return Result.ok(result.value.toDomain(court, complex));
        case Error<CourtAvailabilityDto>():
          _log.warning('Failed to fetch nested information.');
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      _log.warning('Failed to fetch complexes.');
      return Result.error(e);
    }
  }
}

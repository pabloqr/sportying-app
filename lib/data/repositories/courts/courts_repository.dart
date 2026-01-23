import 'package:logging/logging.dart';
import 'package:sportying_app/core/utils/extension_utilities.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/courts/courts_remote_service.dart';
import 'package:sportying_app/data/services/courts/models/court_api_model.dart';
import 'package:sportying_app/data/services/courts/models/court_availability_api_model.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_availability.dart';
import 'package:sportying_app/domain/models/courts/court_status.dart';

abstract class CourtsRepository {
  Future<Result<List<Court>>> getCourts(Complex complex, {Map<String, dynamic>? query});
  // Future<Result<Court>> getCourt(int complexId, int courtId);

  Future<Result<CourtAvailability>> getCourtAvailability(Complex complex, Court court);
}

class CourtsRepositoryImpl implements CourtsRepository {
  final _log = Logger('CourtsRepository');

  CourtsRepositoryImpl({required CourtsRemoteService remoteService}) : _remoteService = remoteService;

  final CourtsRemoteService _remoteService;

  DateTime _calculateNextAvailable(List<CourtAvailabilitySlot> slots) {
    final now = DateTime.now().toUtc().ceilNextHalfHour;

    // Si no hay elementos, está disponible ahora
    if (slots.isEmpty) return now;

    // Filtrar solo franjas ocupadas ocupadas (available == false) y ordenar por fecha inicio
    final occupiedSlots = slots.where((slot) => !slot.available).toList()
      ..sort((a, b) => a.dateIni.compareTo(b.dateIni));

    // Si no hay elementos, está disponible ahora
    if (occupiedSlots.isEmpty) return now;

    final firstSlot = occupiedSlots.first;

    // La primera franja ocupada está en el futuro y hay al menos 1h disponible, está disponible ahora
    if (firstSlot.dateIni.isAfter(now) && firstSlot.dateIni.difference(now).inHours >= 1) return now;

    // Buscar el primer hueco entre franjas ocupadas
    for (int i = 0; i < occupiedSlots.length - 1; ++i) {
      final currentEndTime = occupiedSlots[i].dateEnd;
      final nextStartTime = occupiedSlots[i + 1].dateIni;

      // Si hay hueco entre dos franjas ocupadas
      if (currentEndTime.isBefore(nextStartTime) && currentEndTime.difference(nextStartTime).inHours >= 1) {
        // Devolver el que sea más tarde: el fin de la franja ocupada actual o ahora
        return currentEndTime.isAfter(now) ? currentEndTime : now;
      }
    }

    // Devolver el fin de la última franja ocupada
    return occupiedSlots.last.dateEnd;
  }

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

  @override
  Future<Result<CourtAvailability>> getCourtAvailability(Complex complex, Court court) async {
    try {
      // Obtener las pistas almacenadas en el sistema para el complejo dado
      // TODO: optimización para obtener solo las más relevantes y paginación
      final result = await _remoteService.getCourtAvailability(complex.id, court.id);
      // Obtener el resultado de la operación
      switch (result) {
        case Ok<CourtAvailabilityApiModel>():
          _log.fine('Fetched complexes from server. Getting nested information.');

          final availabilitySlots = result.value.availability.map((slot) {
            return CourtAvailabilitySlot(dateIni: slot.dateIni, dateEnd: slot.dateEnd, available: slot.available);
          }).toList();

          final nextAvailable = _calculateNextAvailable(availabilitySlots);

          return Result.ok(
            // Crear la instancia del modelo de la disponibilidad
            CourtAvailability(
              court: court,
              complex: complex,
              availability: availabilitySlots,
              nextAvailable: nextAvailable,
            ),
          );
        case Error<CourtAvailabilityApiModel>():
          _log.warning('Failed to fetch nested information.');
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      _log.warning('Failed to fetch complexes.');
      return Result.error(e);
    }
  }
}

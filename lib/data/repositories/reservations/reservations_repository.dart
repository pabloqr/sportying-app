import 'package:logging/logging.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/mappers/complex_mapper.dart';
import 'package:sportying_app/data/mappers/court_mapper.dart';
import 'package:sportying_app/data/mappers/reservation_mapper.dart';
import 'package:sportying_app/data/services/remote/complexes/complexes_remote_service.dart';
import 'package:sportying_app/data/services/remote/complexes/models/complex_dto.dart';
import 'package:sportying_app/data/services/remote/courts/courts_remote_service.dart';
import 'package:sportying_app/data/services/remote/courts/models/court_dto.dart';
import 'package:sportying_app/data/services/remote/reservations/models/reservation_dto.dart';
import 'package:sportying_app/data/services/remote/reservations/reservations_remote_service.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/features/core/utils/widget_utilities.dart';

abstract class ReservationsRepository {
  // Future<Result<List<Reservation>>> getReservations({Map<String, dynamic>? query});
  // Future<Result<Reservation>> getReservation(int reservationId);
  Future<Result<List<Reservation>>> getUserReservations(int userId, {Map<String, dynamic>? query});
  // Future<Result<List<Reservation>>> getComplexReservations(int complexId, {Map<String, dynamic>? query});

  // Future<Result<Reservation>> createReservation(Reservation reservation);
  // Future<Result<Reservation>> updateReservation(Reservation reservation);
  // Future<Result<void>> deleteReservation(int reservationId);

  // Future<Result<Reservation>> setReservationStatus(int reservationId, AvailabilityStatus status);
}

class ReservationsRepositoryImpl implements ReservationsRepository {
  final _log = Logger('ReservationsRepository');

  ReservationsRepositoryImpl({
    required ReservationsRemoteService remoteService,
    required ComplexesRemoteService complexesRemoteService,
    required CourtsRemoteService courtsRemoteService,
  }) : _remoteService = remoteService,
       _complexesRemoteService = complexesRemoteService,
       _courtsRemoteService = courtsRemoteService;

  final ReservationsRemoteService _remoteService;
  final ComplexesRemoteService _complexesRemoteService;
  final CourtsRemoteService _courtsRemoteService;

  @override
  Future<Result<List<Reservation>>> getUserReservations(int userId, {Map<String, dynamic>? query}) async {
    try {
      // Obtener las reservas del usuario actual
      final result = await _remoteService.getUserReservations(userId, query);
      // Obtener el resultado de la operación
      switch (result) {
        case Ok<List<ReservationDto>>():
          _log.fine('Fetched reservations from server. Getting nested information.');

          return Result.ok(
            // Necesario para las operaciones asíncronas que se realizan dentro del bucle
            await Future.wait(
              // Procesar todas las reservas obtenidas para transformarlas al modelo que emplea la aplicación
              result.value.map((reservation) async {
                Complex complex;
                Court court;

                // Obtener la información del complejo sobre el que se ha realizado la reserva
                final complexResult = await _complexesRemoteService.getComplex(reservation.complexId);
                // Obtener el resultado de la operación
                switch (complexResult) {
                  case Ok<ComplexDto>():
                    final value = complexResult.value;

                    // Obtener la dirección del complejo en forma de cadena de texto
                    // Si no se tienen las coordenadas, establecer un mensaje por defecto
                    final address = (value.locLatitude != null && value.locLongitude != null)
                        ? await WidgetUtilities.getAddressFromLatLng(value.locLatitude!, value.locLongitude!)
                        : 'No address provided';

                    // Crear la instancia del modelo del complejo
                    complex = value.toDomain(address);
                    break;
                  case Error<ComplexDto>():
                    throw complexResult.error;
                }

                // Obtener la información de la pista sobre la que se ha realizado la reserva
                final courtResult = await _courtsRemoteService.getCourt(reservation.complexId, reservation.courtId);
                // Obtener el resultado de la operación
                switch (courtResult) {
                  case Ok<CourtDto>():
                    // Crear la instancia del modelo de la pista
                    court = courtResult.value.toDomain(complex);
                    break;
                  case Error<CourtDto>():
                    throw courtResult.error;
                }

                _log.fine('Fetched nested information.');

                // Crear la instancia del modelo de la reserva
                return reservation.toDomain(complex, court);
              }).toList(),
            ),
          );
        case Error<List<ReservationDto>>():
          _log.warning('Failed to fetch nested information.');
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      _log.warning('Failed to fetch reservations.');
      return Result.error(e);
    }
  }
}

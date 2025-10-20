import 'package:logging/logging.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/complexes/complexes_remote_service.dart';
import 'package:sportying_app/data/services/complexes/models/complex_api_model.dart';
import 'package:sportying_app/data/services/courts/courts_remote_service.dart';
import 'package:sportying_app/data/services/courts/models/court_api_model.dart';
import 'package:sportying_app/data/services/reservations/models/reservation_api_model.dart';
import 'package:sportying_app/data/services/reservations/reservations_remote_service.dart';
import 'package:sportying_app/domain/models/complexes/complex.dart';
import 'package:sportying_app/domain/models/complexes/sport.dart';
import 'package:sportying_app/domain/models/courts/court.dart';
import 'package:sportying_app/domain/models/courts/court_status.dart';
import 'package:sportying_app/domain/models/reservations/availability_status.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/domain/models/reservations/time_filter.dart';
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
        case Ok<List<ReservationApiModel>>():
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
                  case Ok<ComplexApiModel>():
                    final value = complexResult.value;

                    // Obtener la dirección del complejo en forma de cadena de texto
                    // Si no se tienen las coordenadas, establecer un mensaje por defecto
                    final address = (value.locLatitude != null && value.locLongitude != null)
                        ? await WidgetUtilities.getAddressFromLatLng(value.locLatitude!, value.locLongitude!)
                        : 'No address provided';

                    // Crear la instancia del modelo del complejo
                    complex = Complex(
                      name: value.complexName,
                      timeIni: value.timeIni,
                      timeEnd: value.timeEnd,
                      address: address,
                      locLongitude: value.locLongitude,
                      locLatitude: value.locLatitude,
                      sports: value.sports
                          .map(
                            (valueSport) => Sport.values.firstWhere((sport) {
                              final String name = sport.name.toLowerCase();
                              final String jsonName = valueSport.toLowerCase();
                              return name == jsonName;
                            }),
                          )
                          .toSet(),
                      createdAt: value.createdAt,
                      updatedAt: value.updatedAt,
                    );
                    break;
                  case Error<ComplexApiModel>():
                    throw complexResult.error;
                }

                // Obtener la información de la pista sobre la que se ha realizado la reserva
                final courtResult = await _courtsRemoteService.getCourt(reservation.complexId, reservation.courtId);
                // Obtener el resultado de la operación
                switch (courtResult) {
                  case Ok<CourtApiModel>():
                    final value = courtResult.value;

                    // Crear la instancia del modelo de la pista
                    court = Court(
                      complex: complex,
                      sport: Sport.values.firstWhere((sport) {
                        final String name = sport.name.toLowerCase();
                        final String jsonName = value.sport.toLowerCase();
                        return name == jsonName;
                      }),
                      name: value.name,
                      description: value.description,
                      maxPeople: value.maxPeople,
                      status: CourtStatus.values.firstWhere((status) {
                        final String name = status.name.toLowerCase();
                        final String jsonName = value.status.toLowerCase();
                        return name == jsonName;
                      }),
                      createdAt: value.createdAt,
                      updatedAt: value.updatedAt,
                    );
                    break;
                  case Error<CourtApiModel>():
                    throw courtResult.error;
                }

                _log.fine('Fetched nested information.');

                // Crear la instancia del modelo de la reserva
                return Reservation(
                  id: reservation.id ?? 0,
                  userId: reservation.userId,
                  complex: complex,
                  court: court,
                  dateIni: reservation.dateIni.toLocal(),
                  dateEnd: reservation.dateEnd.toLocal(),
                  status: AvailabilityStatus.values.firstWhere((status) {
                    final String name = status.name.toLowerCase();
                    final String jsonName = reservation.status.toLowerCase();
                    return name == jsonName;
                  }),
                  reservationStatus: ReservationStatus.values.firstWhere((status) {
                    final String name = status.name.toLowerCase();
                    final String jsonName = reservation.reservationStatus.toLowerCase();
                    return name == jsonName;
                  }),
                  timeFilter: TimeFilter.values.firstWhere((filter) {
                    final String name = filter.name.toLowerCase();
                    final String jsonName = reservation.timeFilter.toLowerCase();
                    return name == jsonName;
                  }),
                  createdAt: reservation.createdAt,
                  updatedAt: reservation.updatedAt,
                );
              }).toList(),
            ),
          );
        case Error<List<ReservationApiModel>>():
          _log.warning('Filed to fetch nested information.');
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      _log.warning('Filed to fetch reservations.');
      return Result.error(e);
    }
  }
}

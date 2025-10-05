import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/reservations/models/reservation_api_model.dart';
import 'package:sportying_app/data/services/reservations/reservations_remote_service.dart';
import 'package:sportying_app/domain/models/reservations/availability_status.dart';
// import 'package:sportying_app/domain/models/reservations/availability_status.dart';
import 'package:sportying_app/domain/models/reservations/reservation.dart';
import 'package:sportying_app/domain/models/reservations/reservation_status.dart';
import 'package:sportying_app/domain/models/reservations/time_filter.dart';

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
  ReservationsRepositoryImpl({required ReservationsRemoteService remoteService}) : _remoteService = remoteService;

  final ReservationsRemoteService _remoteService;

  @override
  Future<Result<List<Reservation>>> getUserReservations(int userId, {Map<String, dynamic>? query}) async {
    try {
      final result = await _remoteService.getUserReservations(userId, query);
      switch (result) {
        case Ok<List<ReservationApiModel>>():
          return Result.ok(
            result.value
                .map(
                  (reservation) => Reservation(
                    userId: reservation.userId,
                    complexId: reservation.complexId,
                    courtId: reservation.courtId,
                    dateIni: reservation.dateIni,
                    dateEnd: reservation.dateEnd,
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
                  ),
                )
                .toList(),
          );
        case Error<List<ReservationApiModel>>():
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}

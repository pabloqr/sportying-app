import 'dart:convert';

import 'package:sportying_app/core/utils/exceptions.dart';
import 'package:sportying_app/core/utils/network_utils.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/remote/core/authenticated_http_client.dart';
import 'package:sportying_app/data/services/remote/reservations/models/reservation_dto.dart';

abstract class ReservationsRemoteService {
  // Future<Result<List<ReservationDto>>> getReservations(Map<String, dynamic>? query);
  // Future<Result<ReservationDto>> getReservation(int reservationId);
  Future<Result<List<ReservationDto>>> getUserReservations(int userId, Map<String, dynamic>? query);
  // Future<Result<List<ReservationDto>>> getComplexReservations(int complexId, Map<String, dynamic>? query);

  // Future<Result<ReservationDto>> createReservation(ReservationDto reservation);
  // Future<Result<ReservationDto>> updateReservation(ReservationDto reservation);
  // Future<Result<void>> deleteReservation(int reservationId);

  // Future<Result<ReservationDto>> setReservationStatus(int reservationId, ReservationDto status);
}

class ReservationsRemoteServiceImpl implements ReservationsRemoteService {
  ReservationsRemoteServiceImpl({required AuthenticatedHttpClient client}) : _client = client;

  final AuthenticatedHttpClient _client;

  static const Map<String, Type> _userQueryValidator = {
    'id': int,
    'complexId': int,
    'courtId': int,
    'dateIni': DateTime,
    'dateEnd': DateTime,
    'status': String,
    'reservationStatus': String,
    'timeFilter': String,
    'createdAt': DateTime,
    'updatedAt': DateTime,
  };

  @override
  Future<Result<List<ReservationDto>>> getUserReservations(int userId, Map<String, dynamic>? query) async {
    var uri = Uri.parse('http://100.70.163.216:3000/users/$userId/reservations');

    if (query != null && query.isNotEmpty) {
      final queryParameters = <String, String>{};
      query.forEach((key, value) {
        if (!_userQueryValidator.containsKey(key)) return;

        final type = _userQueryValidator[key]!;
        final valueString = NetworkUtilities.validateQueryValue(type: type, value: value);

        if (valueString != null) queryParameters[key] = valueString;
      });

      uri = uri.replace(queryParameters: queryParameters);
    }

    try {
      final response = await _client.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        return Result.ok(data.map((e) => ReservationDto.fromJson(e as Map<String, dynamic>)).toList());
      } else {
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

        return Result.error(
          NetworkException(data['message'] as String? ?? 'Error getting user reservations: ${response.statusCode}'),
        );
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}

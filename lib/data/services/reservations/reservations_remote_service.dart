import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sportying_app/core/utils/network_utilities.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/reservations/models/reservation_api_model.dart';

abstract class ReservationsRemoteService {
  // Future<Result<List<ReservationApiModel>>> getReservations(Map<String, dynamic>? query);
  // Future<Result<ReservationApiModel>> getReservation(int reservationId);
  Future<Result<List<ReservationApiModel>>> getUserReservations(int userId, Map<String, dynamic>? query);
  // Future<Result<List<ReservationApiModel>>> getComplexReservations(int complexId, Map<String, dynamic>? query);

  // Future<Result<ReservationApiModel>> createReservation(ReservationApiModel reservation);
  // Future<Result<ReservationApiModel>> updateReservation(ReservationApiModel reservation);
  // Future<Result<void>> deleteReservation(int reservationId);

  // Future<Result<ReservationApiModel>> setReservationStatus(int reservationId, ReservationApiModel status);
}

class ReservationsRemoteServiceImpl implements ReservationsRemoteService {
  ReservationsRemoteServiceImpl({required http.Client client}) : _client = client;

  final http.Client _client;

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
  Future<Result<List<ReservationApiModel>>> getUserReservations(int userId, Map<String, dynamic>? query) async {
    Uri uri = Uri.parse('http://100.70.62.176:3000/users/$userId/reservations');

    if (query != null && query.isNotEmpty) {
      Map<String, String> queryParameters = {};
      query.forEach((key, value) {
        if (!_userQueryValidator.containsKey(key)) return;

        Type type = _userQueryValidator[key]!;
        String? valueString = NetworkUtilities.validateQueryValue(type: type, value: value);

        if (valueString != null) queryParameters[key] = valueString;
      });

      uri = uri.replace(queryParameters: queryParameters);
    }

    try {
      final response = await _client.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        return Result.ok(data.map((e) => ReservationApiModel.fromJson(e as Map<String, dynamic>)).toList());
      } else {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

        return Result.error(
          HttpException(data['message'] ?? 'Error getting user reservations: ${response.statusCode}'),
        );
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}

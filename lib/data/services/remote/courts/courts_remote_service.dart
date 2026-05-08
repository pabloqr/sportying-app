import 'dart:convert';

import 'package:sportying_app/core/utils/exceptions.dart';
import 'package:sportying_app/core/utils/network_utils.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/remote/core/authenticated_http_client.dart';
import 'package:sportying_app/data/services/remote/courts/models/court_availability_dto.dart';
import 'package:sportying_app/data/services/remote/courts/models/court_dto.dart';

abstract class CourtsRemoteService {
  Future<Result<List<CourtDto>>> getCourts(int complexId, Map<String, dynamic>? query);

  Future<Result<CourtDto>> getCourt(int complexId, int courtId);

  Future<Result<CourtAvailabilityDto>> getCourtAvailability(int complexId, int courtId);

  // Future<Result<List<DeviceModel>>> getCourtDevices(int complexId, int courtId);
}

class CourtsRemoteServiceImpl implements CourtsRemoteService {
  CourtsRemoteServiceImpl({required AuthenticatedHttpClient client}) : _client = client;

  final AuthenticatedHttpClient _client;

  static const Map<String, Type> _queryValidator = {
    'id': int,
    'sport': String,
    'name': String,
    'description': String,
    'maxPeople': int,
    'status': String,
    'createdAt': DateTime,
    'updatedAt': DateTime,
  };

  @override
  Future<Result<List<CourtDto>>> getCourts(int complexId, Map<String, dynamic>? query) async {
    var uri = Uri.parse('http://100.70.163.216:3000/complexes/$complexId/courts');

    if (query != null && query.isNotEmpty) {
      final queryParameters = <String, String>{};
      query.forEach((key, value) {
        if (!_queryValidator.containsKey(key)) return;

        final type = _queryValidator[key]!;
        final valueString = NetworkUtilities.validateQueryValue(type: type, value: value);

        if (valueString != null) queryParameters[key] = valueString;
      });

      uri = uri.replace(queryParameters: queryParameters);
    }

    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        return Result.ok(data.map((e) => CourtDto.fromJson(e as Map<String, dynamic>)).toList());
      } else {
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        return Result.error(
          NetworkException(data['message'] as String? ?? 'Error getting courts: ${response.statusCode}'),
        );
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<CourtDto>> getCourt(int complexId, int courtId) async {
    final uri = Uri.parse('http://100.70.163.216:3000/complexes/$complexId/courts/$courtId');

    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return Result.ok(CourtDto.fromJson(data as Map<String, dynamic>));
      } else {
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        return Result.error(
          NetworkException(data['message'] as String? ?? 'Error getting courts: ${response.statusCode}'),
        );
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<CourtAvailabilityDto>> getCourtAvailability(int complexId, int courtId) async {
    final uri = Uri.parse('http://100.70.163.216:3000/complexes/$complexId/courts/$courtId/availability');

    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return Result.ok(CourtAvailabilityDto.fromJson(data as Map<String, dynamic>));
      } else {
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        return Result.error(
          NetworkException(data['message'] as String? ?? 'Error getting court availability: ${response.statusCode}'),
        );
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}

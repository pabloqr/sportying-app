import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sportying_app/core/utils/network_utilities.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/courts/models/court_api_model.dart';

abstract class CourtsRemoteService {
  Future<Result<List<CourtApiModel>>> getCourts(int complexId, Map<String, dynamic>? query);
  Future<Result<CourtApiModel>> getCourt(int complexId, int courtId);

  // Future<Result<CourtAvailabilityModel>> getCourtAvailability(int complexId, int courtId);

  // Future<Result<List<DeviceModel>>> getCourtDevices(int complexId, int courtId);
}

class CourtsRemoteServiceImpl implements CourtsRemoteService {
  CourtsRemoteServiceImpl({required http.Client client}) : _client = client;

  final http.Client _client;

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
  Future<Result<List<CourtApiModel>>> getCourts(int complexId, Map<String, dynamic>? query) async {
    Uri uri = Uri.parse('http://100.70.62.176:3000/complexes/$complexId/courts');

    if (query != null && query.isNotEmpty) {
      Map<String, String> queryParameters = {};
      query.forEach((key, value) {
        if (!_queryValidator.containsKey(key)) return;

        Type type = _queryValidator[key]!;
        String? valueString = NetworkUtilities.validateQueryValue(type: type, value: value);

        if (valueString != null) queryParameters[key] = valueString;
      });

      uri = uri.replace(queryParameters: queryParameters);
    }

    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        return Result.ok(data.map((e) => CourtApiModel.fromJson(e)).toList());
      } else {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return Result.error(HttpException(data['message'] ?? 'Error getting courts: ${response.statusCode}'));
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<CourtApiModel>> getCourt(int complexId, int courtId) async {
    Uri uri = Uri.parse('http://100.70.62.176:3000/complexes/$complexId/courts/$courtId');

    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return Result.ok(CourtApiModel.fromJson(data));
      } else {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return Result.error(HttpException(data['message'] ?? 'Error getting complexes: ${response.statusCode}'));
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/courts/models/court_api_model.dart';

abstract class CourtsRemoteService {
  // Future<Result<List<CourtApiModel>>> getCourts(int complexId, {Map<String, dynamic>? query});
  Future<Result<CourtApiModel>> getCourt(int complexId, int courtId);

  // Future<Result<CourtAvailabilityModel>> getCourtAvailability(int complexId, int courtId);

  // Future<Result<List<DeviceModel>>> getCourtDevices(int complexId, int courtId);
}

class CourtsRemoteServiceImpl implements CourtsRemoteService {
  CourtsRemoteServiceImpl({required http.Client client}) : _client = client;

  final http.Client _client;

  // static const Map<String, Type> _queryValidator = {
  //   'id': int,
  //   'sport': String,
  //   'name': String,
  //   'description': String,
  //   'maxPeople': int,
  //   'status': String,
  //   'createdAt': DateTime,
  //   'updatedAt': DateTime,
  // };

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

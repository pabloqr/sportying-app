import 'dart:convert';
import 'dart:io';

import 'package:sportying_app/core/utils/network_utilities.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/complexes/models/complex_api_model.dart';
import 'package:http/http.dart' as http;

abstract class ComplexesRemoteService {
  Future<Result<List<ComplexApiModel>>> getComplexes(Map<String, dynamic>? query);
  // Future<Result<ComplexApiModel>> getComplex(int complexId);
}

class ComplexesRemoteServiceImpl implements ComplexesRemoteService {
  ComplexesRemoteServiceImpl({required http.Client client}) : _client = client;

  final http.Client _client;

  static const Map<String, Type> _queryValidator = {
    'id': int,
    'complexName': String,
    'timeIni': String,
    'timeEnd': String,
    'locLongitude': double,
    'locLatitude': double,
    'createdAt': DateTime,
    'updatedAt': DateTime,
  };

  @override
  Future<Result<List<ComplexApiModel>>> getComplexes(Map<String, dynamic>? query) async {
    Uri uri = Uri.parse('http://100.70.62.176:3000/complexes');

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
        return Result.ok(data.map((e) => ComplexApiModel.fromJson(e)).toList());
      } else {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return Result.error(HttpException(data['message'] ?? 'Error getting complexes: ${response.statusCode}'));
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}

import 'dart:convert';

import 'package:sportying_app/core/utils/exceptions.dart';
import 'package:sportying_app/core/utils/network_utilities.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/remote/complexes/models/complex_dto.dart';
import 'package:sportying_app/data/services/remote/core/authenticated_http_client.dart';

abstract class ComplexesRemoteService {
  Future<Result<List<ComplexDto>>> getComplexes(Map<String, dynamic>? query);

  Future<Result<ComplexDto>> getComplex(int complexId);
}

class ComplexesRemoteServiceImpl implements ComplexesRemoteService {
  ComplexesRemoteServiceImpl({required AuthenticatedHttpClient client}) : _client = client;

  final AuthenticatedHttpClient _client;

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
  Future<Result<List<ComplexDto>>> getComplexes(Map<String, dynamic>? query) async {
    var uri = Uri.parse('http://100.70.163.216:3000/complexes');

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
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
        return Result.ok(data.map((e) => ComplexDto.fromJson(e as Map<String, dynamic>)).toList());
      } else {
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        return Result.error(
          NetworkException(data['message'] as String? ?? 'Error getting complexes: ${response.statusCode}'),
        );
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<ComplexDto>> getComplex(int complexId) async {
    final uri = Uri.parse('http://100.70.163.216:3000/complexes/$complexId');

    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return Result.ok(ComplexDto.fromJson(data as Map<String, dynamic>));
      } else {
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        return Result.error(
          NetworkException(data['message'] as String? ?? 'Error getting complexes: ${response.statusCode}'),
        );
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}

import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:sportying_app/core/utils/exceptions.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/auth/auth_repository.dart';

class AuthenticatedHttpClient {
  AuthenticatedHttpClient({
    required http.Client client,
    required AuthRepository authRepository,
    Duration timeout = const Duration(seconds: 10),
  }) : _client = client,
       _authRepository = authRepository,
       _timeout = timeout;

  final http.Client _client;
  final AuthRepository _authRepository;
  final Duration _timeout;

  //------------------------------------------------------------------------------------------------------------------//

  Future<Map<String, String>> _buildHeaders(Map<String, String>? customHeaders) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?customHeaders,
    };

    final accessToken = _authRepository.accessToken;
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    return headers;
  }

  Future<http.Response> _authenticatedRequest(Future<http.Response> Function() request) async {
    try {
      final response = await request().timeout(
        _timeout,
        onTimeout: () => throw TimeoutException('Connection timeout', _timeout),
      );

      if (response.statusCode == 401) {
        final result = await _authRepository.refreshAuth(_authRepository.refreshToken);
        switch (result) {
          case Ok<void>():
            final newResponse = await request().timeout(
              _timeout,
              onTimeout: () => throw TimeoutException('Connection timeout', _timeout),
            );

            return newResponse;
          case Error<void>():
            throw result.error;
        }
      }

      return response;
    } on TimeoutException catch (e) {
      throw NetworkException('Connection timeout during sign up: ${e.message}');
    } catch (e) {
      throw NetworkException('Network error: ${e.toString()}');
    }
  }

  //------------------------------------------------------------------------------------------------------------------//

  Future<http.Response> get(Uri uri, {Map<String, String>? headers}) async {
    return _authenticatedRequest(() async => _client.get(uri, headers: await _buildHeaders(headers)));
  }

  Future<http.Response> post(Uri uri, {Map<String, String>? headers, String? body}) async {
    return _authenticatedRequest(() async => _client.post(uri, headers: await _buildHeaders(headers), body: body));
  }

  Future<http.Response> put(Uri uri, {Map<String, String>? headers, String? body}) async {
    return _authenticatedRequest(() async => _client.put(uri, headers: await _buildHeaders(headers), body: body));
  }

  Future<http.Response> delete(Uri uri, {Map<String, String>? headers}) async {
    return _authenticatedRequest(() async => _client.delete(uri, headers: await _buildHeaders(headers)));
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sportying_app/core/config/config_service.dart';
import 'package:sportying_app/core/routing/routes.dart';
import 'package:sportying_app/core/utils/exceptions.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/services/remote/auth/models/auth_credentials_dto.dart';
import 'package:sportying_app/data/services/remote/auth/models/sign_in_dto.dart';
import 'package:sportying_app/data/services/remote/auth/models/sign_up_dto.dart';
import 'package:sportying_app/data/services/remote/auth/models/tokens_dto.dart';

abstract class AuthRemoteService {
  Future<Result<AuthCredentialsDto>> signUp(SignUpDto request);

  Future<Result<AuthCredentialsDto>> signIn(SignInDto request);

  Future<Result<TokensDto>> refreshAuth(String refreshToken);

  Future<Result<void>> signOut(String accessToken);
}

class AuthRemoteServiceImpl extends AuthRemoteService {
  AuthRemoteServiceImpl({required http.Client client, required ConfigService configService})
    : _client = client,
      _configService = configService;

  final http.Client _client;

  final ConfigService _configService;

  @override
  Future<Result<AuthCredentialsDto>> signUp(SignUpDto request) async {
    final uri = Uri.parse('${_configService.getApiUrl()}${ServerRoutes.signUpRoute}');

    try {
      final response = await _client
          .post(uri, headers: {'Content-Type': 'application/json'}, body: jsonEncode(request.toJson()))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException('Connection timeout', const Duration(seconds: 10)),
          );

      if (response.statusCode == HttpStatus.created) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return Result.ok(AuthCredentialsDto.fromJson(data as Map<String, dynamic>));
      } else {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return Result.error(NetworkException(data['message'] as String? ?? 'Error signing up: ${response.statusCode}'));
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<AuthCredentialsDto>> signIn(SignInDto request) async {
    final uri = Uri.parse('${_configService.getApiUrl()}${ServerRoutes.signInRoute}');

    try {
      final response = await _client
          .post(uri, headers: {'Content-Type': 'application/json'}, body: jsonEncode(request.toJson()))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException('Connection timeout', const Duration(seconds: 10)),
          );

      if (response.statusCode == HttpStatus.ok) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return Result.ok(AuthCredentialsDto.fromJson(data as Map<String, dynamic>));
      } else {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return Result.error(NetworkException(data['message'] as String? ?? 'Error signing in: ${response.statusCode}'));
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<TokensDto>> refreshAuth(String refreshToken) async {
    final uri = Uri.parse('${_configService.getApiUrl()}${ServerRoutes.refreshAuthRoute}');

    try {
      final response = await _client
          .post(uri, headers: {'Content-Type': 'application/json'}, body: json.encode({'refreshToken': refreshToken}))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException('Connection timeout', const Duration(seconds: 10)),
          );

      if (response.statusCode == HttpStatus.ok) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return Result.ok(TokensDto.fromJson(data as Map<String, dynamic>));
      } else {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return Result.error(
          NetworkException(data['message'] as String? ?? 'Error refreshing tokens: ${response.statusCode}'),
        );
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> signOut(String accessToken) async {
    final uri = Uri.parse('${_configService.getApiUrl()}${ServerRoutes.signOutRoute}');

    try {
      final response = await _client
          .post(uri, headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $accessToken'})
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException('Connection timeout', const Duration(seconds: 10)),
          );

      if (response.statusCode == HttpStatus.ok) {
        return Result.ok(null);
      } else {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return Result.error(
          NetworkException(data['message'] as String? ?? 'Error signing out: ${response.statusCode}'),
        );
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}

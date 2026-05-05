import 'dart:convert';

import 'package:sportying_app/core/storage/secure_storage_service.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/mappers/user_mapper.dart';
import 'package:sportying_app/data/services/remote/users/models/user_dto.dart';
import 'package:sportying_app/domain/models/auth/tokens.dart';
import 'package:sportying_app/domain/models/users/user.dart';

class AuthLocalService {
  AuthLocalService({required SecureStorageService secureStorage}) : _secureStorage = secureStorage;

  final SecureStorageService _secureStorage;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _expiresInKey = 'expires_in';

  static const String _userKey = 'user_model';

  Future<Result<String?>> getAccessToken() async {
    try {
      final value = await _secureStorage.read(_accessTokenKey);
      return Result.ok(value);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<String?>> getRefreshToken() async {
    try {
      final value = await _secureStorage.read(_refreshTokenKey);
      return Result.ok(value);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<DateTime?>> getExpiresIn() async {
    try {
      final value = await _secureStorage.read(_expiresInKey);
      if (value == null) return Result.ok(null);
      return Result.ok(DateTime.fromMillisecondsSinceEpoch(int.parse(value)));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<User?>> getUser() async {
    try {
      // Obtener el valor almacenado para el usuario
      final json = await _secureStorage.read(_userKey);

      // Si no se encuentra almacenado, devolver un valor nulo
      if (json == null) return Result.ok(null);

      // Devolver el modelo del usuario construido a partir del objeto JSON
      return Result.ok(UserDto.fromJson(jsonDecode(json) as Map<String, dynamic>).toDomain());
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> saveTokens(Tokens tokens) async {
    try {
      // Calcular la fecha de expiración de los tokens a partir de los segundos para la expiración
      final expiresAt = DateTime.now().add(Duration(seconds: tokens.expiresIn)).millisecondsSinceEpoch;

      // Escribir los valores en el almacenamiento seguro
      await Future.wait([
        _secureStorage.write(_accessTokenKey, tokens.accessToken),
        _secureStorage.write(_refreshTokenKey, tokens.refreshToken),
        _secureStorage.write(_expiresInKey, expiresAt.toString()),
      ]);

      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> saveUser(User user) async {
    try {
      await _secureStorage.write(_userKey, jsonEncode(user.toDto().toJson()));
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> saveAuth(Tokens tokens, User user) async {
    try {
      await Future.wait([saveTokens(tokens), saveUser(user)]);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> clearTokens() async {
    try {
      await Future.wait([
        _secureStorage.delete(_accessTokenKey),
        _secureStorage.delete(_refreshTokenKey),
        _secureStorage.delete(_expiresInKey),
      ]);

      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> clearUser() async {
    try {
      await _secureStorage.delete(_userKey);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> clearAuth() async {
    try {
      await Future.wait([clearTokens(), clearAuth()]);
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}

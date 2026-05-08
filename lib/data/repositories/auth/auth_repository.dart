import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:sportying_app/core/utils/exceptions.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/core/utils/result_utils.dart';
import 'package:sportying_app/data/mappers/auth/auth_credentials_mapper.dart';
import 'package:sportying_app/data/mappers/auth/sign_in_mapper.dart';
import 'package:sportying_app/data/mappers/auth/sign_up_mapper.dart';
import 'package:sportying_app/data/mappers/auth/tokens_mapper.dart';
import 'package:sportying_app/data/services/local/auth_local_service.dart';
import 'package:sportying_app/data/services/remote/auth/auth_remote_service.dart';
import 'package:sportying_app/data/services/remote/auth/models/auth_credentials_dto.dart';
import 'package:sportying_app/data/services/remote/auth/models/tokens_dto.dart';
import 'package:sportying_app/domain/models/auth/sign_in.dart';
import 'package:sportying_app/domain/models/auth/sign_up.dart';
import 'package:sportying_app/domain/models/auth/tokens.dart';
import 'package:sportying_app/domain/models/users/user.dart';

abstract class AuthRepository extends ChangeNotifier {
  String? _accessToken;
  String? _refreshToken;
  User? _user;

  //------------------------------------------------------------------------------------------------------------------//

  String? get accessToken => _accessToken;

  String? get refreshToken => _refreshToken;

  User? get user => _user;

  //------------------------------------------------------------------------------------------------------------------//

  Future<Result<void>> signUp(SignUp request);

  Future<Result<void>> signIn(SignIn request);

  Future<Result<void>> refreshAuth([String? refreshToken]);

  Future<Result<void>> signOut([String? accessToken]);

  //------------------------------------------------------------------------------------------------------------------//

  Future<Result<bool>> autoAuth();
}

class AuthRepositoryImpl extends AuthRepository {
  final _log = Logger('AuthRepository');

  AuthRepositoryImpl({required AuthRemoteService remoteService, required AuthLocalService localService})
    : _remoteService = remoteService,
      _localService = localService;

  final AuthRemoteService _remoteService;
  final AuthLocalService _localService;

  //------------------------------------------------------------------------------------------------------------------//

  bool get _isAuthenticated => _accessToken != null && _refreshToken != null && _user != null;

  //------------------------------------------------------------------------------------------------------------------//

  void _updateLocalAuth(String accessToken, String refreshToken, [User? user]) {
    // Actualizar los tokens en memoria
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    // Actualizar el modelo del usuario en memoria
    _user = user ?? _user;
  }

  void _clearLocalAuth() {
    // Limpiar los tokens en memoria
    _accessToken = null;
    _refreshToken = null;
    // Limpiar el modelo del usuario en memoria
    _user = null;
  }

  Future<Result<void>> _saveAuth(Tokens tokens, [User? user]) async {
    // Actualizar el almacenamiento local
    final result = user == null ? await _localService.saveTokens(tokens) : await _localService.saveAuth(tokens, user);

    // Si falla, devolver el error
    if (result is Error) return Result.error(result.error);

    // Actualizar los datos de autenticación en memoria
    _updateLocalAuth(tokens.accessToken, tokens.refreshToken, user);

    return Result.ok(null);
  }

  Future<Result<void>> _clearAuth() async {
    // Limpiar el almacenamiento local
    final result = await _localService.clearAuth();

    // Si falla, devolver el error
    if (result is Error) return Result.error(result.error);

    // Limpiar los datos de autenticación en memoria
    _clearLocalAuth();

    return Result.ok(null);
  }

  Future<Result<String?>> _resolveAccessToken([String? token]) async {
    if (token != null) return Result.ok(token);
    return _localService.getAccessToken();
  }

  Future<Result<String?>> _resolveRefreshToken([String? token]) async {
    if (token != null) return Result.ok(token);
    return _localService.getRefreshToken();
  }

  //------------------------------------------------------------------------------------------------------------------//

  @override
  Future<Result<void>> signUp(SignUp request) async {
    try {
      // Crear la cuenta en el servidor
      final result = await _remoteService.signUp(request.toDto());
      // Obtener el resultado de la operación
      switch (result) {
        case Ok<AuthCredentialsDto>():
          _log.fine('Created user account. Parsing tokens and user information.');

          // Actualizar el objeto recibido al modelo del dominio
          final authCredentials = result.value.toDomain();

          // Actualizar el almacenamiento local
          final saveResult = await _saveAuth(
            Tokens(
              accessToken: authCredentials.accessToken,
              refreshToken: authCredentials.refreshToken,
              expiresIn: authCredentials.expiresIn,
            ),
            authCredentials.user,
          );
          // Si ha ocurrido un error en el almacenamiento, devolver el error
          if (saveResult is Error) {
            _log.severe('Failed to save auth data in local storage.');
            return Result.error(saveResult.error);
          }

          notifyListeners();
          return Result.ok(null);
        case Error<AuthCredentialsDto>():
          _log.warning('Failed to create user account.');
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      _log.warning('Failed to create user account.');
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> signIn(SignIn request) async {
    try {
      // Iniciar sesión
      final result = await _remoteService.signIn(request.toDto());
      // Obtener el resultado de la operación
      switch (result) {
        case Ok<AuthCredentialsDto>():
          _log.fine('Signed user in. Parsing tokens and user information.');

          // Actualizar el objeto recibido al modelo del dominio
          final authCredentials = result.value.toDomain();

          // Actualizar el almacenamiento local
          final saveResult = await _saveAuth(
            Tokens(
              accessToken: authCredentials.accessToken,
              refreshToken: authCredentials.refreshToken,
              expiresIn: authCredentials.expiresIn,
            ),
            authCredentials.user,
          );
          // Si ha ocurrido un error en el almacenamiento, devolver el error
          if (saveResult is Error) {
            _log.severe('Failed to save auth data in local storage.');
            return Result.error(saveResult.error);
          }

          notifyListeners();
          return Result.ok(null);
        case Error<AuthCredentialsDto>():
          _log.warning('Failed to sign in.');
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      _log.warning('Failed to sign in.');
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> refreshAuth([String? refreshToken]) async {
    try {
      final tokenResult = await _resolveRefreshToken(refreshToken);
      switch (tokenResult) {
        case Ok<String?>():
          final token = tokenResult.value;
          if (token == null) {
            return Result.error(
              CacheException('No refresh token found. Please sign in before refreshing your tokens.'),
            );
          }

          // Solicitar los tokens al servidor
          final result = await _remoteService.refreshAuth(token);
          // Obtener el resultado de la operación
          switch (result) {
            case Ok<TokensDto>():
              _log.fine('Refreshed tokens. Parsing them.');

              // Actualizar el objeto recibido al modelo del dominio
              final tokens = result.value.toDomain();

              // Actualizar el almacenamiento local
              final saveResult = await _saveAuth(tokens);
              // Si ha ocurrido un error en el almacenamiento, devolver el error
              if (saveResult is Error) {
                _log.severe('Failed to save tokens in local storage.');
                return Result.error(saveResult.error);
              }

              notifyListeners();
              return Result.ok(null);
            case Error<TokensDto>():
              _log.warning('Failed to refresh tokens from server.');
              return Result.error(result.error);
          }
        case Error<String?>():
          _log.severe('Failed to get tokens from local storage.');
          return Result.error(tokenResult.error);
      }
    } on Exception catch (e) {
      _log.warning('Failed to refresh tokens.');
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> signOut([String? accessToken]) async {
    try {
      final tokenResult = await _resolveAccessToken(accessToken);
      switch (tokenResult) {
        case Ok<String?>():
          final token = tokenResult.value;

          if (token == null) {
            _log.fine('No access token found in local storage. Clearing auth data.');

            // Limpiar el almacenamiento local
            final clearResult = await _clearAuth();
            if (clearResult is Error) {
              _log.severe('Failed to clear auth data in local storage.');

              return Result.error(clearResult.error);
            }

            notifyListeners();
            return Result.ok(null);
          }

          // Cerrar sesión en el servidor
          final result = await _remoteService.signOut(token);
          // Obtener el resultado de la operación
          switch (result) {
            case Ok<void>():
              _log.fine('Signed user out. Clearing auth data.');

              // Limpiar el almacenamiento local
              final clearResult = await _clearAuth();
              if (clearResult is Error) {
                _log.severe('Failed to clear auth data in local storage.');

                return Result.error(clearResult.error);
              }

              notifyListeners();
              return Result.ok(null);
            case Error<void>():
              _log.warning('Failed to sign out.');
              return Result.error(result.error);
          }
        case Error<String?>():
          _log.severe('Failed to get tokens from local storage.');
          return Result.error(tokenResult.error);
      }
    } on Exception catch (e) {
      _log.warning('Failed to sign out.');
      return Result.error(e);
    }
  }

  //------------------------------------------------------------------------------------------------------------------//

  @override
  Future<Result<bool>> autoAuth() async {
    try {
      if (_isAuthenticated) return Result.ok(true);

      // Obtener los valores del almacenamiento local
      final results = await Future.wait([
        _localService.getAccessToken(),
        _localService.getRefreshToken(),
        _localService.getExpiresIn(),
        _localService.getUser(),
      ]);

      final accessToken = ResultUtils.unwrapOrThrow(results[0] as Result<String?>);
      final refreshToken = ResultUtils.unwrapOrThrow(results[1] as Result<String?>);
      final expiresAt = ResultUtils.unwrapOrThrow(results[2] as Result<DateTime?>);
      final user = ResultUtils.unwrapOrThrow(results[3] as Result<User?>);

      // Verificar que todos los elementos son válidos
      if (accessToken != null && refreshToken != null && user != null && expiresAt != null) {
        // Verificar si la sesión ha expirado
        final isExpired = DateTime.now().isAfter(expiresAt.subtract(const Duration(seconds: 30)));
        if (!isExpired) {
          // Si no ha expirado, actualizar los datos de autenticación en memoria
          _updateLocalAuth(accessToken, refreshToken, user);

          notifyListeners();
          return Result.ok(true);
        }

        // Antes de refrescar, actualizar el usuario en memoria, ya que no se actualiza en el método
        _user = user;

        // Si ha expirado, refrescar los tokens
        final refreshResult = await refreshAuth(refreshToken);
        switch (refreshResult) {
          case Ok<void>():
            return Result.ok(true);
          case Error<void>():
            return Result.error(refreshResult.error);
        }
      }

      // Si alguno de los elementos no es válido, no se puede iniciar sesión de forma automática
      return Result.ok(false);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}

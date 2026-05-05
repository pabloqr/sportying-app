import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:sportying_app/core/utils/exceptions.dart';
import 'package:sportying_app/core/utils/result.dart';
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

  //------------------------------------------------------------------------------------------------------------------//

  String? get accessToken => _accessToken;

  String? get refreshToken => _refreshToken;

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
          final saveResult = await _localService.saveAuth(
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

          // Actualizar los tokens locales
          _accessToken = authCredentials.accessToken;
          _refreshToken = authCredentials.refreshToken;

          return Result.ok(null);
        case Error<AuthCredentialsDto>():
          _log.warning('Failed to create user account.');
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      _log.warning('Failed to create user account.');
      return Result.error(e);
    } finally {
      notifyListeners();
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
          final saveResult = await _localService.saveAuth(
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

          // Actualizar los tokens locales
          _accessToken = authCredentials.accessToken;
          _refreshToken = authCredentials.refreshToken;

          return Result.ok(null);
        case Error<AuthCredentialsDto>():
          _log.warning('Failed to sign in.');
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      _log.warning('Failed to sign in.');
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> refreshAuth([String? refreshToken]) async {
    try {
      var token = refreshToken;

      if (token == null) {
        final result = await _localService.getRefreshToken();
        switch (result) {
          case Ok<String?>():
            token = result.value;
            break;
          case Error<String?>():
            _log.severe('Failed to get tokens from local storage.');
            break;
        }

        if (token == null) {
          return Result.error(CacheException('No refresh token found. Please sign in before refreshing your tokens.'));
        }
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
          final saveResult = await _localService.saveTokens(tokens);
          // Si ha ocurrido un error en el almacenamiento, devolver el error
          if (saveResult is Error) {
            _log.severe('Failed to save tokens in local storage.');
            return Result.error(saveResult.error);
          }

          // Actualizar los tokens locales
          _accessToken = tokens.accessToken;
          _refreshToken = tokens.refreshToken;

          return Result.ok(null);
        case Error<TokensDto>():
          _log.warning('Failed to refresh tokens from server.');
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      _log.warning('Failed to refresh tokens.');
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> signOut([String? accessToken]) async {
    try {
      var token = accessToken;

      if (token == null) {
        final result = await _localService.getAccessToken();
        switch (result) {
          case Ok<String?>():
            token = result.value;
            break;
          case Error<String?>():
            _log.severe('Failed to get tokens from local storage.');

            return Result.error(result.error);
        }

        if (token == null) {
          _log.fine('No access token found in local storage. Clearing auth data.');

          // Limpiar el almacenamiento local
          final clearResult = await _localService.clearAuth();
          if (clearResult is Error) {
            _log.severe('Failed to clear auth data in local storage.');
          }

          // Limpiar los tokens locales
          _accessToken = null;
          _refreshToken = null;

          return Result.ok(null);
        }
      }

      // Cerrar sesión en el servidor
      final result = await _remoteService.signOut(token);
      // Obtener el resultado de la operación
      switch (result) {
        case Ok<void>():
          _log.fine('Signed user out. Clearing auth data.');

          // Limpiar el almacenamiento local
          final clearResult = await _localService.clearAuth();
          if (clearResult is Error) {
            _log.severe('Failed to clear auth data in local storage.');
          }

          // Limpiar los tokens locales
          _accessToken = null;
          _refreshToken = null;

          return Result.ok(null);
        case Error<void>():
          _log.warning('Failed to sign out.');
          return Result.error(result.error);
      }
    } on Exception catch (e) {
      _log.warning('Failed to sign out.');
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  //------------------------------------------------------------------------------------------------------------------//

  @override
  Future<Result<bool>> autoAuth() async {
    try {
      // Obtener los valores del almacenamiento local
      final values = await Future.wait([
        _localService.getAccessToken(),
        _localService.getRefreshToken(),
        _localService.getExpiresIn(),
        _localService.getUser(),
      ]);

      final accessToken = values[0] is Error ? null : (values[0] as Ok<String?>).value;
      final refreshToken = values[1] is Error ? null : (values[1] as Ok<String?>).value;
      final expiresAt = values[2] is Error ? null : (values[2] as Ok<DateTime?>).value;
      final user = values[3] is Error ? null : (values[3] as Ok<User?>).value;

      // Verificar que todos los elementos son válidos
      if (accessToken != null && refreshToken != null && user != null && expiresAt != null) {
        // Verificar si la sesión ha expirado
        final isExpired = DateTime.now().isAfter(expiresAt.subtract(const Duration(seconds: 30)));
        if (isExpired) {
          // Si ha expirado, refrescar los tokens
          final refreshResult = await refreshAuth(refreshToken);
          switch (refreshResult) {
            case Ok<void>():
              return Result.ok(true);
            case Error<void>():
              return Result.error(refreshResult.error);
          }
        }
      }

      // Si alguno de los elementos no es válido, no se puede iniciar sesión de forma automática
      return Result.ok(false);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}

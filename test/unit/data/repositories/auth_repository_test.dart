import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sportying_app/core/utils/exceptions.dart';
import 'package:sportying_app/core/utils/result.dart';
import 'package:sportying_app/data/repositories/auth/auth_repository.dart';
import 'package:sportying_app/data/services/local/auth_local_service.dart';
import 'package:sportying_app/data/services/remote/auth/auth_remote_service.dart';
import 'package:sportying_app/data/services/remote/auth/models/auth_credentials_dto.dart';
import 'package:sportying_app/data/services/remote/auth/models/sign_in_dto.dart';
import 'package:sportying_app/data/services/remote/auth/models/sign_up_dto.dart';
import 'package:sportying_app/data/services/remote/auth/models/tokens_dto.dart';
import 'package:sportying_app/data/services/remote/users/models/user_dto.dart';
import 'package:sportying_app/domain/models/auth/sign_in.dart';
import 'package:sportying_app/domain/models/auth/sign_up.dart';
import 'package:sportying_app/domain/models/auth/tokens.dart';
import 'package:sportying_app/domain/models/users/user.dart';

class MockAuthRemoteService extends Mock implements AuthRemoteService {}

class MockAuthLocalService extends Mock implements AuthLocalService {}

class FakeSignUpDto extends Fake implements SignUpDto {}

class FakeSignInDto extends Fake implements SignInDto {}

class FakeTokens extends Fake implements Tokens {}

class FakeUser extends Fake implements User {}

void main() {
  late MockAuthRemoteService remoteService;
  late MockAuthLocalService localService;
  late AuthRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(FakeSignUpDto());
    registerFallbackValue(FakeSignInDto());
    registerFallbackValue(FakeTokens());
    registerFallbackValue(FakeUser());
  });

  setUp(() {
    remoteService = MockAuthRemoteService();
    localService = MockAuthLocalService();
    repository = AuthRepositoryImpl(remoteService: remoteService, localService: localService);
  });

  final now = DateTime.now();
  final userDto = UserDto(
    id: 1,
    role: 'client',
    name: 'John',
    surname: 'Doe',
    mail: 'john@doe.com',
    phonePrefix: 34,
    phoneNumber: 123456789,
    createdAt: now,
    updatedAt: now,
  );

  final authCredentialsDto = AuthCredentialsDto(
    accessToken: 'access_token_123',
    refreshToken: 'refresh_token_123',
    expiresIn: 3600,
    user: userDto,
  );

  final userDomain = User(
    id: 1,
    role: Role.client,
    name: 'John',
    surname: 'Doe',
    mail: 'john@doe.com',
    phonePrefix: 34,
    phoneNumber: 123456789,
    createdAt: now,
    updatedAt: now,
  );

  group('AuthRepositoryImpl - signUp', () {
    const signUpRequest = SignUp(
      name: 'John',
      surname: 'Doe',
      mail: 'john@doe.com',
      phonePrefix: 34,
      phoneNumber: 123456789,
      password: 'password123',
    );

    test('signUp success saves auth and notifies listeners', () async {
      when(() => remoteService.signUp(any())).thenAnswer((_) async => Result.ok(authCredentialsDto));
      when(() => localService.saveAuth(any(), any())).thenAnswer((_) async => const Result.ok(null));

      var listenerNotified = false;
      repository.addListener(() {
        listenerNotified = true;
      });

      final result = await repository.signUp(signUpRequest);

      expect(result, isA<Ok<void>>());
      expect(repository.accessToken, equals('access_token_123'));
      expect(repository.refreshToken, equals('refresh_token_123'));
      expect(repository.user, equals(userDomain));
      expect(listenerNotified, isTrue);

      verify(() => remoteService.signUp(any())).called(1);
      verify(() => localService.saveAuth(any(), any())).called(1);
    });

    test('signUp failure returns error', () async {
      final exception = Exception('Sign up failed');
      when(() => remoteService.signUp(any())).thenAnswer((_) async => Result.error(exception));

      final result = await repository.signUp(signUpRequest);

      expect(result, isA<Error<void>>());
      expect((result as Error).error, equals(exception));
      expect(repository.accessToken, isNull);
    });

    test('signUp returns local storage and thrown remote failures', () async {
      final storageFailure = Exception('Storage failed');
      when(() => remoteService.signUp(any())).thenAnswer((_) async => Result.ok(authCredentialsDto));
      when(() => localService.saveAuth(any(), any())).thenAnswer((_) async => Result.error(storageFailure));

      final storageResult = await repository.signUp(signUpRequest);

      expect((storageResult as Error<void>).error, same(storageFailure));

      final remoteFailure = Exception('Remote threw');
      reset(remoteService);
      when(() => remoteService.signUp(any())).thenThrow(remoteFailure);

      final thrownResult = await repository.signUp(signUpRequest);

      expect((thrownResult as Error<void>).error, same(remoteFailure));
    });
  });

  group('AuthRepositoryImpl - signIn', () {
    const signInRequest = SignIn(mail: 'john@doe.com', password: 'password123');

    test('signIn success saves auth and updates state', () async {
      when(() => remoteService.signIn(any())).thenAnswer((_) async => Result.ok(authCredentialsDto));
      when(() => localService.saveAuth(any(), any())).thenAnswer((_) async => const Result.ok(null));

      final result = await repository.signIn(signInRequest);

      expect(result, isA<Ok<void>>());
      expect(repository.accessToken, equals('access_token_123'));
      expect(repository.user, equals(userDomain));

      verify(() => remoteService.signIn(any())).called(1);
      verify(() => localService.saveAuth(any(), any())).called(1);
    });

    test('signIn local storage failure returns local storage error', () async {
      final exception = Exception('Storage failed');
      when(() => remoteService.signIn(any())).thenAnswer((_) async => Result.ok(authCredentialsDto));
      when(() => localService.saveAuth(any(), any())).thenAnswer((_) async => Result.error(exception));

      final result = await repository.signIn(signInRequest);

      expect(result, isA<Error<void>>());
      expect((result as Error).error, equals(exception));
      expect(repository.accessToken, isNull);
    });

    test('signIn returns remote result and thrown failures', () async {
      final remoteFailure = Exception('Rejected');
      when(() => remoteService.signIn(any())).thenAnswer((_) async => Result.error(remoteFailure));

      final result = await repository.signIn(signInRequest);

      expect((result as Error<void>).error, same(remoteFailure));

      reset(remoteService);
      when(() => remoteService.signIn(any())).thenThrow(remoteFailure);

      final thrownResult = await repository.signIn(signInRequest);

      expect((thrownResult as Error<void>).error, same(remoteFailure));
    });
  });

  group('AuthRepositoryImpl - refreshAuth', () {
    final tokensDto = const TokensDto(
      accessToken: 'new_access_token',
      refreshToken: 'new_refresh_token',
      expiresIn: 3600,
    );

    test('refreshAuth success with provided token', () async {
      when(() => remoteService.refreshAuth(any())).thenAnswer((_) async => Result.ok(tokensDto));
      when(() => localService.saveTokens(any())).thenAnswer((_) async => const Result.ok(null));

      final result = await repository.refreshAuth('my_refresh_token');

      expect(result, isA<Ok<void>>());
      expect(repository.accessToken, equals('new_access_token'));
      expect(repository.refreshToken, equals('new_refresh_token'));

      verify(() => remoteService.refreshAuth('my_refresh_token')).called(1);
      verify(() => localService.saveTokens(any())).called(1);
    });

    test('refreshAuth success with stored token', () async {
      when(() => localService.getRefreshToken()).thenAnswer((_) async => const Result.ok('stored_refresh_token'));
      when(() => remoteService.refreshAuth(any())).thenAnswer((_) async => Result.ok(tokensDto));
      when(() => localService.saveTokens(any())).thenAnswer((_) async => const Result.ok(null));

      final result = await repository.refreshAuth();

      expect(result, isA<Ok<void>>());
      expect(repository.accessToken, equals('new_access_token'));

      verify(() => localService.getRefreshToken()).called(1);
      verify(() => remoteService.refreshAuth('stored_refresh_token')).called(1);
    });

    test('refreshAuth rejects missing or unavailable local tokens', () async {
      when(() => localService.getRefreshToken()).thenAnswer((_) async => const Result.ok(null));

      final missingResult = await repository.refreshAuth();

      expect((missingResult as Error<void>).error, isA<CacheException>());

      final failure = Exception('Storage failed');
      reset(localService);
      when(() => localService.getRefreshToken()).thenAnswer((_) async => Result.error(failure));

      final failedReadResult = await repository.refreshAuth();

      expect((failedReadResult as Error<void>).error, same(failure));
    });

    test('refreshAuth returns remote and persistence failures', () async {
      final remoteFailure = Exception('Refresh rejected');
      when(() => remoteService.refreshAuth('token')).thenAnswer((_) async => Result.error(remoteFailure));

      final remoteResult = await repository.refreshAuth('token');

      expect((remoteResult as Error<void>).error, same(remoteFailure));

      final storageFailure = Exception('Save failed');
      reset(remoteService);
      when(() => remoteService.refreshAuth('token')).thenAnswer((_) async => Result.ok(tokensDto));
      when(() => localService.saveTokens(any())).thenAnswer((_) async => Result.error(storageFailure));

      final storageResult = await repository.refreshAuth('token');

      expect((storageResult as Error<void>).error, same(storageFailure));
    });

    test('refreshAuth returns thrown dependency failures', () async {
      final failure = Exception('Refresh request crashed');
      when(() => remoteService.refreshAuth('token')).thenThrow(failure);

      final result = await repository.refreshAuth('token');

      expect((result as Error<void>).error, same(failure));
    });
  });

  group('AuthRepositoryImpl - signOut', () {
    test('signOut success calls remote and clears local storage', () async {
      when(() => localService.getAccessToken()).thenAnswer((_) async => const Result.ok('token_to_clear'));
      when(() => remoteService.signOut(any())).thenAnswer((_) async => const Result.ok(null));
      when(() => localService.clearAuth()).thenAnswer((_) async => const Result.ok(null));

      final result = await repository.signOut();

      expect(result, isA<Ok<void>>());
      expect(repository.accessToken, isNull);

      verify(() => remoteService.signOut('token_to_clear')).called(1);
      verify(() => localService.clearAuth()).called(1);
    });

    test('signOut without a stored token clears only local authentication', () async {
      when(() => localService.getAccessToken()).thenAnswer((_) async => const Result.ok(null));
      when(() => localService.clearAuth()).thenAnswer((_) async => const Result.ok(null));

      final result = await repository.signOut();

      expect(result, isA<Ok<void>>());
      verifyNever(() => remoteService.signOut(any()));
      verify(() => localService.clearAuth()).called(1);
    });

    test('signOut returns read, remote, and clear failures', () async {
      final failure = Exception('failure');
      when(() => localService.getAccessToken()).thenAnswer((_) async => Result.error(failure));
      expect((await repository.signOut() as Error<void>).error, same(failure));

      reset(localService);
      when(() => remoteService.signOut('token')).thenAnswer((_) async => Result.error(failure));
      expect((await repository.signOut('token') as Error<void>).error, same(failure));

      reset(remoteService);
      when(() => remoteService.signOut('token')).thenAnswer((_) async => const Result.ok(null));
      when(() => localService.clearAuth()).thenAnswer((_) async => Result.error(failure));
      expect((await repository.signOut('token') as Error<void>).error, same(failure));
    });

    test('signOut returns clear failure without a token and thrown remote failure', () async {
      final failure = Exception('failure');
      when(() => localService.getAccessToken()).thenAnswer((_) async => const Result.ok(null));
      when(() => localService.clearAuth()).thenAnswer((_) async => Result.error(failure));

      expect((await repository.signOut() as Error<void>).error, same(failure));
      verifyNever(() => remoteService.signOut(any()));

      reset(remoteService);
      when(() => remoteService.signOut('token')).thenThrow(failure);

      expect((await repository.signOut('token') as Error<void>).error, same(failure));
    });
  });

  group('AuthRepositoryImpl - autoAuth', () {
    test('autoAuth returns true if already authenticated in memory', () async {
      // Manually authenticate in memory via mock setup and signIn
      when(() => remoteService.signIn(any())).thenAnswer((_) async => Result.ok(authCredentialsDto));
      when(() => localService.saveAuth(any(), any())).thenAnswer((_) async => const Result.ok(null));

      await repository.signIn(const SignIn(mail: 'john@doe.com', password: 'password123'));

      final result = await repository.autoAuth();
      expect(result, isA<Ok<bool>>());
      expect((result as Ok<bool>).value, isTrue);

      verify(() => remoteService.signIn(any())).called(1);
      verify(() => localService.saveAuth(any(), any())).called(1);
      verifyNoMoreInteractions(localService);
    });

    test('autoAuth returns true and restores session if storage contains valid non-expired credentials', () async {
      final futureExpires = DateTime.now().add(const Duration(hours: 1));

      when(() => localService.getAccessToken()).thenAnswer((_) async => const Result.ok('stored_access'));
      when(() => localService.getRefreshToken()).thenAnswer((_) async => const Result.ok('stored_refresh'));
      when(() => localService.getExpiresIn()).thenAnswer((_) async => Result.ok(futureExpires));
      when(() => localService.getUser()).thenAnswer((_) async => Result.ok(userDomain));

      final result = await repository.autoAuth();

      expect(result, isA<Ok<bool>>());
      expect((result as Ok<bool>).value, isTrue);
      expect(repository.accessToken, equals('stored_access'));
      expect(repository.user, equals(userDomain));
    });

    test('autoAuth refreshes tokens if stored session is expired', () async {
      final pastExpires = DateTime.now().subtract(const Duration(minutes: 10));
      final newTokensDto = const TokensDto(
        accessToken: 'refreshed_access',
        refreshToken: 'refreshed_refresh',
        expiresIn: 3600,
      );

      when(() => localService.getAccessToken()).thenAnswer((_) async => const Result.ok('stored_access'));
      when(() => localService.getRefreshToken()).thenAnswer((_) async => const Result.ok('expired_refresh'));
      when(() => localService.getExpiresIn()).thenAnswer((_) async => Result.ok(pastExpires));
      when(() => localService.getUser()).thenAnswer((_) async => Result.ok(userDomain));

      when(() => remoteService.refreshAuth(any())).thenAnswer((_) async => Result.ok(newTokensDto));
      when(() => localService.saveTokens(any())).thenAnswer((_) async => const Result.ok(null));

      final result = await repository.autoAuth();

      expect(result, isA<Ok<bool>>());
      expect((result as Ok<bool>).value, isTrue);
      expect(repository.accessToken, equals('refreshed_access'));

      verify(() => remoteService.refreshAuth('expired_refresh')).called(1);
    });

    test('autoAuth returns false if storage has no credentials', () async {
      when(() => localService.getAccessToken()).thenAnswer((_) async => const Result.ok(null));
      when(() => localService.getRefreshToken()).thenAnswer((_) async => const Result.ok(null));
      when(() => localService.getExpiresIn()).thenAnswer((_) async => const Result.ok(null));
      when(() => localService.getUser()).thenAnswer((_) async => const Result.ok(null));

      final result = await repository.autoAuth();

      expect(result, isA<Ok<bool>>());
      expect((result as Ok<bool>).value, isFalse);
    });

    test('autoAuth returns a refresh failure from an expired stored session', () async {
      final failure = Exception('Refresh failed');
      when(() => localService.getAccessToken()).thenAnswer((_) async => const Result.ok('stored_access'));
      when(() => localService.getRefreshToken()).thenAnswer((_) async => const Result.ok('stored_refresh'));
      when(
        () => localService.getExpiresIn(),
      ).thenAnswer((_) async => Result.ok(DateTime.now().subtract(const Duration(minutes: 1))));
      when(() => localService.getUser()).thenAnswer((_) async => Result.ok(userDomain));
      when(() => remoteService.refreshAuth('stored_refresh')).thenAnswer((_) async => Result.error(failure));

      final result = await repository.autoAuth();

      expect((result as Error<bool>).error, same(failure));
    });

    test('autoAuth returns local storage failures', () async {
      final failure = Exception('Read failed');
      when(() => localService.getAccessToken()).thenAnswer((_) async => Result.error(failure));
      when(() => localService.getRefreshToken()).thenAnswer((_) async => const Result.ok(null));
      when(() => localService.getExpiresIn()).thenAnswer((_) async => const Result.ok(null));
      when(() => localService.getUser()).thenAnswer((_) async => const Result.ok(null));

      final result = await repository.autoAuth();

      expect((result as Error<bool>).error, same(failure));
    });
  });
}

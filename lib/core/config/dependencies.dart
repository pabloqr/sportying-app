import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportying_app/core/config/config_service.dart';
import 'package:sportying_app/core/storage/secure_storage_service.dart';
import 'package:sportying_app/core/storage/storage_service.dart';
import 'package:sportying_app/data/repositories/auth/auth_repository.dart';
import 'package:sportying_app/data/repositories/complexes/complexes_repository.dart';
import 'package:sportying_app/data/repositories/courts/courts_repository.dart';
import 'package:sportying_app/data/repositories/reservations/reservations_repository.dart';
import 'package:sportying_app/data/services/local/auth_local_service.dart';
import 'package:sportying_app/data/services/local/secure_storage_service_impl.dart';
import 'package:sportying_app/data/services/local/shared_prefs_storage_service.dart';
import 'package:sportying_app/data/services/remote/auth/auth_remote_service.dart';
import 'package:sportying_app/data/services/remote/complexes/complexes_remote_service.dart';
import 'package:sportying_app/data/services/remote/core/authenticated_http_client.dart';
import 'package:sportying_app/data/services/remote/courts/courts_remote_service.dart';
import 'package:sportying_app/data/services/remote/reservations/reservations_remote_service.dart';
import 'package:sportying_app/features/core/widgets/visuals/time_range_selector.dart';

List<SingleChildWidget> getAppProviders({required SharedPreferences sharedPreferences}) {
  return [
    // ---------------------------------------------------------------------------------------------------------------//
    // BASE DEPENDENCIES
    // ---------------------------------------------------------------------------------------------------------------//
    Provider<http.Client>(create: (_) => http.Client(), dispose: (_, client) => client.close()),

    Provider<FlutterSecureStorage>(create: (_) => const FlutterSecureStorage()),
    Provider<SharedPreferences>.value(value: sharedPreferences),

    // ---------------------------------------------------------------------------------------------------------------//
    // SERVICES LEVEL 1 (No dependencies on other custom services)
    // ---------------------------------------------------------------------------------------------------------------//
    Provider<ConfigService>(create: (context) => ConfigService(sharedPreferences: context.read<SharedPreferences>())),

    Provider<StorageService>(
      create: (context) => SharedPrefsStorageService(sharedPreferences: context.read<SharedPreferences>()),
    ),
    Provider<SecureStorageService>(
      create: (context) => SecureStorageServiceImpl(secureStorage: context.read<FlutterSecureStorage>()),
    ),

    Provider(create: (context) => AuthLocalService(secureStorage: context.read())),

    Provider(
      create: (context) =>
          AuthRemoteServiceImpl(client: context.read(), configService: context.read()) as AuthRemoteService,
    ),

    // ---------------------------------------------------------------------------------------------------------------//
    // REPOSITORIES LEVEL 1 (Depend on services from level 1)
    // ---------------------------------------------------------------------------------------------------------------//
    ChangeNotifierProvider<AuthRepository>(
      create: (context) =>
          AuthRepositoryImpl(remoteService: context.read(), localService: context.read()) as AuthRepository,
    ),

    // ---------------------------------------------------------------------------------------------------------------//
    // SERVICES LEVEL 2 (Depend on repositories or services from level 2)
    // ---------------------------------------------------------------------------------------------------------------//
    Provider<AuthenticatedHttpClient>(
      create: (context) => AuthenticatedHttpClient(client: context.read(), authRepository: context.read()),
    ),

    Provider(create: (context) => ComplexesRemoteServiceImpl(client: context.read()) as ComplexesRemoteService),
    Provider(create: (context) => CourtsRemoteServiceImpl(client: context.read()) as CourtsRemoteService),
    Provider(create: (context) => ReservationsRemoteServiceImpl(client: context.read()) as ReservationsRemoteService),

    // ---------------------------------------------------------------------------------------------------------------//
    // REPOSITORIES LEVEL 2 (Depend on services from level 2)
    // ---------------------------------------------------------------------------------------------------------------//
    Provider(create: (context) => ComplexesRepositoryImpl(remoteService: context.read()) as ComplexesRepository),
    Provider(create: (context) => CourtsRepositoryImpl(remoteService: context.read()) as CourtsRepository),
    Provider(
      create: (context) =>
          ReservationsRepositoryImpl(
                remoteService: context.read(),
                complexesRemoteService: context.read(),
                courtsRemoteService: context.read(),
              )
              as ReservationsRepository,
    ),

    // ---------------------------------------------------------------------------------------------------------------//
    // PROVIDERS (ChangeNotifiers)
    // ---------------------------------------------------------------------------------------------------------------//
    ChangeNotifierProvider<TimeRangeController>(create: (_) => TimeRangeController()),
  ];
}

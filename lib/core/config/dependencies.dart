import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sportying_app/data/repositories/complexes/complexes_repository.dart';
import 'package:sportying_app/data/repositories/reservations/reservations_repository.dart';
import 'package:sportying_app/data/services/complexes/complexes_remote_service.dart';
import 'package:sportying_app/data/services/courts/courts_remote_service.dart';
import 'package:sportying_app/data/services/reservations/reservations_remote_service.dart';

List<SingleChildWidget> get appProviders {
  return [
    // ---------------------------------------------------------------------------------------------------------------//
    // BASE DEPENDENCIES
    // ---------------------------------------------------------------------------------------------------------------//
    Provider<http.Client>(create: (_) => http.Client(), dispose: (_, client) => client.close()),

    // ---------------------------------------------------------------------------------------------------------------//
    // SERVICES LEVEL 1 (No dependencies on other custom services)
    // ---------------------------------------------------------------------------------------------------------------//
    Provider(create: (context) => ComplexesRemoteServiceImpl(client: context.read()) as ComplexesRemoteService),
    Provider(create: (context) => CourtsRemoteServiceImpl(client: context.read()) as CourtsRemoteService),
    Provider(create: (context) => ReservationsRemoteServiceImpl(client: context.read()) as ReservationsRemoteService),

    // ---------------------------------------------------------------------------------------------------------------//
    // REPOSITORIES LEVEL 1 (Depend on services from level 1)
    // ---------------------------------------------------------------------------------------------------------------//
    Provider(create: (context) => ComplexesRepositoryImpl(remoteService: context.read()) as ComplexesRepository),
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
    // SERVICES LEVEL 2 (Depend on repositories)
    // ---------------------------------------------------------------------------------------------------------------//

    // ---------------------------------------------------------------------------------------------------------------//
    // REPOSITORIES LEVEL 2 (Depend on services from level 2)
    // ---------------------------------------------------------------------------------------------------------------//

    // ---------------------------------------------------------------------------------------------------------------//
    // PROVIDERS (ChangeNotifiers)
    // ---------------------------------------------------------------------------------------------------------------//
  ];
}

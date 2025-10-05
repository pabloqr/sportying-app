import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportying_app/data/repositories/complexes/complexes_repository.dart';
import 'package:sportying_app/data/repositories/reservations/reservations_repository.dart';
import 'package:sportying_app/data/services/complexes/complexes_remote_service.dart';
import 'package:sportying_app/data/services/reservations/reservations_remote_service.dart';
import 'package:sportying_app/features/users/view_model/client_dashboard_viewmodel.dart';
import 'package:sportying_app/features/users/widgets/client_dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    http.Client client = http.Client();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ClientDashboardScreen(
        viewModel: ClientDashboardViewModel(
          complexesRepository: ComplexesRepositoryImpl(remoteService: ComplexesRemoteServiceImpl(client: client)),
          reservationRepository: ReservationsRepositoryImpl(
            remoteService: ReservationsRemoteServiceImpl(client: client),
          ),
        ),
      ),
    );
  }
}

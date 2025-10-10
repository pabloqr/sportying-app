import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportying_app/core/config/dependencies.dart';
import 'package:sportying_app/core/routing/router.dart';
import 'package:sportying_app/features/core/themes/theme.dart';

void main() {
  runApp(MultiProvider(providers: appProviders, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = ClientTheme();
    // http.Client client = http.Client();

    return MaterialApp.router(title: 'Flutter Demo', theme: theme.light, routerConfig: router());
  }
}

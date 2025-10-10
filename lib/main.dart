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

  @override
  Widget build(BuildContext context) {
    final theme = ClientTheme();

    return MaterialApp.router(
      title: 'Sporty.ing',
      theme: theme.light,
      darkTheme: theme.dark,
      themeMode: ThemeMode.light,
      routerConfig: router(),
    );
  }
}

import 'package:flutter/material.dart';

import 'config/config.dart';

class RandomUserApp extends StatelessWidget {
  final color = RandomUserAppTheme.orange.color;

  RandomUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: theme(color, Brightness.light),
      darkTheme: theme(color, Brightness.dark),
      themeMode: ThemeMode.system,
      initialRoute: defaultRoute,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
    );
  }
}
import 'package:flutter/material.dart';

import 'config/config.dart';

class RandomUserApp extends StatelessWidget {
  const RandomUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Random User App',
      initialRoute: defaultRoute,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
    );
  }
}

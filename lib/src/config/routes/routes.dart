import 'package:flutter/material.dart';

import 'package:rua/src/features/home/presentation/views/home.dart';
import 'package:rua/src/features/home/presentation/views/settings.dart';

import 'route_names.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _materialRoute(const Home());

      case settingsRoute:
        return _materialRoute(const Settings());

      case randomUserRoute:
        return _materialRoute(const Home());

      case customUserRoute:
        return _materialRoute(const Home());

      case userDetailsRoute:
        return _materialRoute(const Home());

      case savedUsersRoute:
        return _materialRoute(const Home());

      case qrScannerRoute:
        return _materialRoute(const Home());

      default:
        return _materialRoute(const Home());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
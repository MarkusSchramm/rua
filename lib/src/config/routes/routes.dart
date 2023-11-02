import 'package:flutter/material.dart';

import 'package:rua/src/features/home/presentation/views/home.dart';
import 'package:rua/src/features/home/presentation/views/settings.dart';
import 'package:rua/src/features/random_user/presentation/views/custom_user_generator.dart';
import 'package:rua/src/features/random_user/presentation/views/qr_scanner.dart';
import 'package:rua/src/features/random_user/presentation/views/random_user_generator.dart';
import 'package:rua/src/features/random_user/presentation/views/saved_users.dart';
import 'package:rua/src/features/random_user/presentation/views/user_details.dart';

import 'route_names.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return _materialRoute(const Home());

      case settingsRoute:
        return _materialRoute(const Settings());

      case randomUserRoute:
        return _materialRoute(const RandomUserGenerator());

      case customUserRoute:
        return _materialRoute(const CustomUserGenerator());

      case userDetailsRoute:
        return _materialRoute(const UserDetails());

      case savedUsersRoute:
        return _materialRoute(const SavedUsers());

      case qrScannerRoute:
        return _materialRoute(const QrScanner());

      default:
        return _materialRoute(const Home());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
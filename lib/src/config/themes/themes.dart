import 'package:flutter/material.dart';

ThemeData theme(MaterialColor color, Brightness brightness) {
  return ThemeData(
    appBarTheme: _appBarTheme(),
    drawerTheme: _drawerTheme(),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: color,
      brightness: brightness,
    ),
    //useMaterial3: true,
  );
}

AppBarTheme _appBarTheme() {
  return const AppBarTheme(
    elevation: 40,
    centerTitle: true,
  );
}

DrawerThemeData _drawerTheme() {
  return const DrawerThemeData(
    elevation: 30,
  );
}
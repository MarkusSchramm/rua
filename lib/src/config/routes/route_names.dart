import 'package:flutter/material.dart';

const String appTitle = 'Random User App';
const String defaultRoute = '/';

const String homeRoute = '/home';
const String homeName = 'Home';

const String settingsRoute = '/settings';
const String settingsName = 'Settings';

const String randomUserRoute = '/random-user';
const String randomUserName = 'Random User Generator';

const String customUserRoute = '/custom-user';
const String customUserName = 'Custom User Generator';

const String userDetailsRoute = '/user-details';
const String userDetailsName = 'User Details';

const String savedUsersRoute = '/saved-users';
const String savedUsersName = 'Saved Users';

const String qrScannerRoute = '/qr-scanner';
const String qrScannerName = 'QR Scanner';

enum RandomUserAppRoute {
  home(homeRoute, homeName, Icons.home),
  settings(settingsRoute, settingsName, Icons.settings),
  randomUserGen(randomUserRoute, randomUserName, Icons.person_add_outlined),
  customUserGen(customUserRoute, customUserName, Icons.person_add),
  savedUsers(savedUsersRoute, savedUsersName, Icons.people),
  qrScanner(qrScannerRoute, qrScannerName, Icons.qr_code);

  final String route;
  final String name;
  final IconData icon;

  const RandomUserAppRoute(this.route, this.name, this.icon);
}
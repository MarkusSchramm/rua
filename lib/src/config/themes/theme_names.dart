import 'package:flutter/material.dart';

enum RandomUserAppTheme {
  blue('Blue Theme', Colors.blue),
  indigo('Indigo Theme', Colors.indigo),
  blueGrey('Blue-Grey Theme', Colors.blueGrey),
  orange('Orange Theme', Colors.orange),
  green('Green Theme', Colors.green),
  purple('Purple Theme', Colors.purple);

  final String name;
  final MaterialColor color;

  const RandomUserAppTheme(this.name, this.color);
}
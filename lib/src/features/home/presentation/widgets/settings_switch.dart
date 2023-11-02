import 'package:flutter/material.dart';

import 'package:rua/src/random_user_app.dart';

class SettingsSwitch extends StatefulWidget {
  const SettingsSwitch({super.key});

  @override
  State<SettingsSwitch> createState() => _SettingsSwitchState();
}

class _SettingsSwitchState extends State<SettingsSwitch> {
  bool _isDark = ThemeMode.system == ThemeMode.dark;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isDark =
          RandomUserApp.of(context)?.getCurrentThemeMode() == ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isDark,
      onChanged: (value) {
        RandomUserApp.of(context)?.changeThemeMode(
            mode: value ? ThemeMode.dark : ThemeMode.light);
        setState(() {
          _isDark = value;
        });
      }
    );
  }
}

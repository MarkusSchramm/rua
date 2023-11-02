import 'package:flutter/material.dart';

import 'package:rua/src/config/config.dart';
import 'package:rua/src/random_user_app.dart';

class SettingsButton extends StatelessWidget {
  final RandomUserAppTheme theme;

  const SettingsButton({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: theme.color == Theme.of(context).colorScheme.primary
          ? null : () {
        RandomUserApp.of(context)?.changeColor(theme: theme);
      },
      child: SizedBox(
          width: double.infinity,
          child: Text(theme.name)
      ),
    );
  }
}
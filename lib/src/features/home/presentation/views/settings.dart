import 'package:flutter/material.dart';

import 'package:rua/src/config/config.dart';
import 'package:rua/src/random_user_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/settings_button.dart';
import '../widgets/settings_switch.dart';

class Settings extends StatelessWidget {
  final String name = settingsName;

  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RuaAppBar(parentName: name),
      drawer: RuaDrawer(parentName: name),
      body: Column(
          children: <Widget>[
            const Row(
              children: <Widget>[
                Text('App Mode'),
                SettingsSwitch(),
              ],
            ),
            const Text('Main Color'),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                itemCount: RandomUserAppTheme.values.length,
                itemBuilder: (context, index) {
                  return SettingsButton(theme: RandomUserAppTheme.values[index]);
                }
              ),
            ),
            Row(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () => savePreferences(context),
                    child: const Text('Save Changes'),
                ),
                ElevatedButton(
                  onPressed: () => setDefaults(context),
                  child: const Text('Discard Changes'),
                ),
              ],
            ),
          ],
        ),
    );
  }

  Future savePreferences(BuildContext context) async {
    int themeNum = RandomUserApp.of(context)!.getCurrentThemeNum();
    ThemeMode themeMode = RandomUserApp.of(context)!.getCurrentThemeMode();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mode = 'system';

    if (themeMode == ThemeMode.system) {
      mode = 'system';
    }
    if (themeMode == ThemeMode.light) {
      mode = 'light';
    }
    if (themeMode == ThemeMode.dark) {
      mode = 'dark';
    }

    await prefs.setInt('Theme', themeNum);
    await prefs.setString('ThemeMode', mode);
  }

  Future deletePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void setDefaults(BuildContext context) {
    RandomUserApp.of(context)?.changeColor(theme: RandomUserAppTheme.blue);
    RandomUserApp.of(context)?.changeThemeMode(mode: ThemeMode.system);
    deletePreferences();
    Navigator.pushNamed(context, settingsRoute);
  }
}

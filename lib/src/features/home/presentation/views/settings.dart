import 'package:flutter/material.dart';

import 'package:rua/src/config/config.dart';
import 'package:rua/src/random_user_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../random_user/presentation/widgets/bottom_button.dart';
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
      bottomNavigationBar: _buildBottomBar(context),
      body: Column(
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Light Mode'),
                SettingsSwitch(),
                Text('Dark Mode'),
              ],
            ),
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
          ],
        ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Builder(
      builder: (context) =>
          BottomAppBar(
            child: Row(
              children: [
                BottomButton(
                  icon: Icons.delete,
                  toolTip: 'Delete User',
                  onPressed: () => _onDeleteButtonPressed(context),
                ),
                BottomButton(
                  icon: RandomUserAppRoute.home.icon,
                  toolTip: RandomUserAppRoute.home.name,
                  onPressed: () => _onHomeButtonPressed(context),
                ),
                BottomButton(
                  icon: Icons.save,
                  toolTip: 'Save User',
                  onPressed: () => _onSaveButtonPressed(context),
                ),
              ],
            ),
          ),
    );
  }

  void _onDeleteButtonPressed(BuildContext context) {
    setDefaults(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings deleted successfully.'),
      ),
    );
  }

  void _onHomeButtonPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, homeRoute);
  }

  void _onSaveButtonPressed(BuildContext context) {
    savePreferences(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Settings saved successfully.'),
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
    Navigator.pushReplacementNamed(context, settingsRoute);
  }
}

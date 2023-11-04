import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rua/src/features/random_user/presentation/viewmodels/custom_user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/config.dart';
import 'core/core.dart';
import 'features/random_user/presentation/viewmodels/local_user_bloc.dart';
import 'features/random_user/presentation/viewmodels/remote_user_bloc.dart';

class RandomUserApp extends StatefulWidget {

  const RandomUserApp({super.key});

  @override
  State<RandomUserApp> createState() => _RandomUserAppState();

  static _RandomUserAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_RandomUserAppState>();
}

class _RandomUserAppState extends State<RandomUserApp> {
  int _themeNum = 0;
  String _themeMode = 'system';
  MaterialColor _color = RandomUserAppTheme.blue.color;
  ThemeMode _mode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    readAndWritePreferences();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteUserBloc>(create: (context) => sl<RemoteUserBloc>()),
        BlocProvider<LocalUserBloc>(create: (context) => sl<LocalUserBloc>()),
        BlocProvider<CustomUserBloc>(create: (context) => sl<CustomUserBloc>())
      ],
      child: MaterialApp(
        title: appTitle,
        theme: theme(_color, Brightness.light),
        darkTheme: theme(_color, Brightness.dark),
        themeMode: _mode,
        initialRoute: defaultRoute,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
      ),
    );
  }

  Future readAndWritePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _themeNum = prefs.getInt('Theme')?? 0;
    _themeMode = prefs.getString('ThemeMode')?? 'system';
    setState(() {
      _color = RandomUserAppTheme.values[_themeNum].color;
      if(_themeMode == 'system') {
        _mode = ThemeMode.system;
      }
      if(_themeMode == 'light'){
        _mode = ThemeMode.light;
      }
      if(_themeMode == 'dark'){
        _mode = ThemeMode.dark;
      }
    });
  }

  void changeColor({required RandomUserAppTheme theme}) {
    setState(() {
      _color = theme.color;
      _themeNum = theme.index;
    });
  }

  void changeThemeMode({required ThemeMode mode}) {
    setState(() {
      _mode = mode;
    });
  }

  int getCurrentThemeNum() => _themeNum;

  ThemeMode getCurrentThemeMode() => _mode;
}
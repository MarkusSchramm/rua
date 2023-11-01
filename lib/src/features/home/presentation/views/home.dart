import 'package:flutter/material.dart';

import 'package:rua/src/config/config.dart';

class Home extends StatelessWidget {
  final String name = homeName;

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RuaAppBar(parentName: name),
      drawer: RuaDrawer(parentName: name),
      body: Center(child: Text(name)),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:rua/src/config/config.dart';

class RandomUserGenerator extends StatelessWidget {
  final String name = randomUserName;

  const RandomUserGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RuaAppBar(parentName: name),
      drawer: RuaDrawer(parentName: name),
      body: Center(
        child: Text(name),
      ),
    );
  }
}
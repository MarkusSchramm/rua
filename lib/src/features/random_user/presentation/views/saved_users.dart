import 'package:flutter/material.dart';

import 'package:rua/src/config/config.dart';

class SavedUsers extends StatelessWidget {
  final String name = savedUsersName;

  const SavedUsers({super.key});

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
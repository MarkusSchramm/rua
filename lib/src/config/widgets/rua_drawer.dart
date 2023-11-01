import 'package:flutter/material.dart';

import 'package:rua/src/config/config.dart';

class RuaDrawer extends StatelessWidget {
  final String parentName;

  const RuaDrawer({
    super.key,
    required this.parentName
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: RandomUserAppRoute.values.length,
          itemBuilder: (context, index) {
            return RuaNavButton(
                route: RandomUserAppRoute.values[index],
                parentName: parentName
            );
          },
        ),
      ),
    );
  }
}

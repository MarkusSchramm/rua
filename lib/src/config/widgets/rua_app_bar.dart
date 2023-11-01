import 'package:flutter/material.dart';

import 'package:rua/src/config/routes/route_names.dart';

class RuaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String parentName;

  //@TODO: adjust height
  const RuaAppBar({
    super.key,
    this.height = 70,
    required this.parentName
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(parentName == homeName ? appTitle : parentName)
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

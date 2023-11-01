import 'package:flutter/material.dart';

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
    return AppBar(title: Text(parentName));
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

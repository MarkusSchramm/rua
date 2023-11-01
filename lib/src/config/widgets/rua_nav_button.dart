import 'package:flutter/material.dart';

import 'package:rua/src/config/config.dart';

class RuaNavButton extends StatelessWidget {
  final RandomUserAppRoute route;
  final String parentName;

  const RuaNavButton({
    super.key,
    required this.route,
    required this.parentName
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: route.name == parentName ? null : () {
        Navigator.pushNamed(context, route.route);
      },
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(route.name),
            Icon(route.icon),
          ],
        )
      ),
    );
  }
}

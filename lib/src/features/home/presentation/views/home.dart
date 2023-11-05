import 'package:flutter/material.dart';

import 'package:rua/src/config/config.dart';
import 'package:rua/src/features/random_user/domain/entities/user_entity.dart';

import '../../../random_user/presentation/widgets/bottom_button.dart';

class Home extends StatelessWidget {
  final String name = homeName;

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RuaAppBar(parentName: name),
      drawer: RuaDrawer(parentName: name),
      bottomNavigationBar: _buildBottomBar(context),
      body: Center(
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.w700
          )
        ),
      ),
    );
  }

  _buildBottomBar(BuildContext context) {
    return  BottomAppBar(
        child: Row(
          children: [
            BottomButton(
              icon: RandomUserAppRoute.randomUserGen.icon,
              toolTip: RandomUserAppRoute.randomUserGen.name,
              onPressed: () => _onRandomGeneratorButtonPressed(context),
            ),
            BottomButton(
              icon: RandomUserAppRoute.home.icon,
              toolTip: RandomUserAppRoute.home.name,
              onPressed: () => _onHomeButtonPressed(context),
            ),
            BottomButton(
              icon: RandomUserAppRoute.customUserGen.icon,
              toolTip: RandomUserAppRoute.customUserGen.name,
              onPressed: () => _onCustomGeneratorButtonPressed(context),
            ),
          ],
        ),
    );
  }

  void _onHomeButtonPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, homeRoute);
  }

  void _onCustomGeneratorButtonPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, customUserRoute, arguments: const UserEntity(email: ''));
  }

  void _onRandomGeneratorButtonPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, randomUserRoute);
  }
}

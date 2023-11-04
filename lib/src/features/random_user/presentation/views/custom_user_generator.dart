import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rua/src/config/config.dart';

import '../../domain/entities/user_entity.dart';
import '../viewmodels/local_user_bloc.dart';
import '../viewmodels/local_user_event.dart';
import '../widgets/bottom_button.dart';
import '../widgets/description_text.dart';

class CustomUserGenerator extends StatelessWidget {
  final UserEntity? user;
  final String name = customUserName;

  const CustomUserGenerator({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RuaAppBar(parentName: name),
      drawer: RuaDrawer(parentName: name),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildUserImage(),
        _buildUserInformation(),
      ],
    );
  }

  Widget _buildUserImage() {
    if(user!.urlToLargeImage != null) {
      return Container(
        width: double.maxFinite,
        height: 250,
        margin: const EdgeInsets.all(14.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(user!.urlToLargeImage!, fit: BoxFit.cover)
        ),
      );
    }
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.all(14.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: const Icon(Icons.person, size: 200)
      ));
  }

  Widget _buildUserInformation() {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const DescriptionText(description: 'FIRSTNAME'),
                    Text(user!.firstName?? '')
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const DescriptionText(description: 'LASTNAME'),
                    Text(user!.lastName?? '')
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Column(
            children: [
              const DescriptionText(description: 'AGE'),
              Text(user!.birthDay?? ''),
            ],
          ),
          const SizedBox(height: 40.0),
          Column(
            children: [
              const DescriptionText(description: 'EMAIL'),
              Text(user!.email?? ''),
            ],
          ),
          const SizedBox(height: 20.0),
          Column(
            children: [
              const DescriptionText(description: 'PHONE'),
              Text(user!.phone?? ''),
            ],
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
                  toolTip: 'Discard Changes',
                  onPressed: () => Navigator.pop(context),
                ),
                BottomButton(
                  icon: RandomUserAppRoute.home.icon,
                  toolTip: RandomUserAppRoute.home.name,
                  onPressed: () => Navigator.pushNamed(context, homeRoute),
                ),
                BottomButton(
                  icon: Icons.save,
                  toolTip: 'Save User',
                  onPressed: () => _onSaveButtonPressed(context, user!),
                ),
              ],
            ),
          ),
    );
  }

  void _onSaveButtonPressed(BuildContext context, UserEntity user) {
    BlocProvider.of<LocalUserBloc>(context).add(SaveUser(user: user));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User saved successfully.'),
      ),
    );
    Navigator.of(context).pushNamed(savedUsersRoute);
  }
}
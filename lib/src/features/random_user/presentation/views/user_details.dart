import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:rua/src/config/config.dart';
import 'package:rua/src/core/core.dart';

import '../../domain/entities/user_entity.dart';
import '../viewmodels/local_user_bloc.dart';
import '../viewmodels/local_user_event.dart';
import '../widgets/description_text.dart';
import '../widgets/bottom_button.dart';

class UserDetails extends HookWidget {
  final String name = userDetailsName;
  final UserEntity? user;

  const UserDetails({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalUserBloc>(
      create: (_) => sl<LocalUserBloc>(),
      child: Scaffold(
        appBar: RuaAppBar(parentName: name),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomBar(context),
      ),
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
    if(user!.urlToLargeImage == null) {
      return Container(
          width: double.maxFinite,
          height: 250,
          margin: const EdgeInsets.all(14.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: const Icon(Icons.person, size: 200)
          ));
    }
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
          const SizedBox(height: 40.0),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const DescriptionText(description: 'BIRTHDAY'),
                    Text('${user?.birthDay?? 'dd'}.${user?.birthMonth?? 'mm'}.${user?.birthYear?? 'yyyy'}'),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    const DescriptionText(description: 'AGE'),
                    Text((user!.age?? 0).toString()),
                  ],
                ),
              ),
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
              Text(user!.phone?? 'no phone number'),
            ],
          ),
          if(user?.email != '') QrImageView(data: user!.email!, size: 150)
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
                  toolTip: 'Delete User',
                  onPressed: () => _onDeleteButtonPressed(context, user!),
                ),
                BottomButton(
                  icon: RandomUserAppRoute.home.icon,
                  toolTip: RandomUserAppRoute.home.name,
                  onPressed: () => _onHomeButtonPressed(context),
                ),
                BottomButton(
                  icon: Icons.edit,
                  toolTip: 'Edit User Details',
                  onPressed: () => _onEditButtonPressed(context, user!),
                ),
              ],
            ),
          ),
    );
  }

  void _onDeleteButtonPressed(BuildContext context, UserEntity user) {
    BlocProvider.of<LocalUserBloc>(context).add(RemoveUser(user: user));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User deleted successfully.'),
      ),
    );
    Navigator.pushReplacementNamed(context, savedUsersRoute);
  }

  void _onHomeButtonPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, homeRoute);
  }

  void _onEditButtonPressed(BuildContext context, UserEntity user) {
    Navigator.pushReplacementNamed(context, customUserRoute, arguments: user);
  }
}
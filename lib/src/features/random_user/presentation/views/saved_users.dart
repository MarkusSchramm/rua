import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rua/src/config/config.dart';
import 'package:rua/src/core/core.dart';
import 'package:rua/src/features/random_user/presentation/widgets/bottom_button.dart';

import '../../domain/entities/user_entity.dart';
import '../viewmodels/local_user_bloc.dart';
import '../viewmodels/local_user_event.dart';
import '../viewmodels/local_user_state.dart';
import '../widgets/user_card.dart';

class SavedUsers extends StatelessWidget {
  final String name = savedUsersName;

  const SavedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalUserBloc>(
      create: (_) => sl<LocalUserBloc>()..add(const GetSavedUsers()),
      child: Scaffold(
        appBar: RuaAppBar(parentName: name),
        drawer: RuaDrawer(parentName: name),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LocalUserBloc, LocalUserState>(
      builder: (context, state) {
        if (state is LocalUserLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is LocalUserDone) {
          return _buildUserList(state.users!);
        }
        return Container();
      },
    );
  }

  Widget _buildUserList(List<UserEntity> users) {
    if (users.isEmpty) {
      return const Center(
          child: Text('NO SAVED USERS'));
    }
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserCard(
          user: users[index],
          isRemovable: true,
          onRemove: (user) => _onRemoveUser(context, user),
          onUserPressed: (user) => _onUserPressed(context, user),
        );
      },
    );
  }

  _buildBottomBar(BuildContext context) {
    return BlocBuilder<LocalUserBloc, LocalUserState> (
      builder: (context, state) => BottomAppBar(
        child: Row(
          children: [
            BottomButton(
              icon: Icons.delete,
              flex: 2,
              toolTip: 'Delete All Saved Users',
              onPressed: () => _onDeleteButtonPressed(context),
            ),
            BottomButton(
              icon: RandomUserAppRoute.home.icon,
              toolTip: RandomUserAppRoute.home.name,
              onPressed: () => _onHomeButtonPressed(context),
            ),
            BottomButton(
              icon: RandomUserAppRoute.randomUserGen.icon,
              toolTip: RandomUserAppRoute.randomUserGen.name,
              onPressed: () => _onGeneratorButtonPressed(context),
            ),
            BottomButton(
              icon: RandomUserAppRoute.customUserGen.icon,
              toolTip: RandomUserAppRoute.customUserGen.name,
              onPressed: () => _onGeneratorButtonPressed(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onDeleteButtonPressed(BuildContext context) {
    BlocProvider.of<LocalUserBloc>(context).add(const RemoveAllUsers());
    BlocProvider.of<LocalUserBloc>(context).add(const GetSavedUsers());
  }

  void _onHomeButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, homeRoute);
  }

  void _onGeneratorButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, randomUserRoute);
  }

  void _onRemoveUser(BuildContext context, UserEntity user) {
    BlocProvider.of<LocalUserBloc>(context).add(RemoveUser(user: user));
  }

  void _onUserPressed(BuildContext context, UserEntity user) {
    Navigator.pushNamed(context, userDetailsRoute, arguments: user);
  }
}
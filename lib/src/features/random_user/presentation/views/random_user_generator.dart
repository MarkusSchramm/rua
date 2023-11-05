import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rua/src/config/config.dart';

import '../../domain/entities/user_entity.dart';
import '../viewmodels/local_user_bloc.dart';
import '../viewmodels/local_user_event.dart';
import '../viewmodels/local_user_state.dart';
import '../viewmodels/remote_user_bloc.dart';
import '../viewmodels/remote_user_event.dart';
import '../viewmodels/remote_user_state.dart';
import '../widgets/user_card.dart';
import '../widgets/bottom_button.dart';

class RandomUserGenerator extends StatefulWidget {

  const RandomUserGenerator({super.key});

  @override
  State<RandomUserGenerator> createState() => _RandomUserGeneratorState();
}

class _RandomUserGeneratorState extends State<RandomUserGenerator> {
  final String name = randomUserName;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isInit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RuaAppBar(parentName: name),
      drawer: RuaDrawer(parentName: name),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBody(context) {
    if(_isInit){
      return BlocBuilder<RemoteUserBloc, RemoteUserState> (
        builder: (_,state) {
          if (state is RemoteUserLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is RemoteUserError) {
            return const Center(child: Icon(Icons.refresh));
          }
          if (state is RemoteUserDone && state.generatedUsers!.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    UserCard(
                        user: state.generatedUsers![index],
                        onUserPressed: (user) => _onUserPressed(context, user)
                    ),
                    const SizedBox(height: 14.0)
                  ],
                );
              },
              itemCount: state.generatedUsers!.length,
            );
          }
          return const Center(
              child: Text('NO GENERATED USERS')
          );
        });
    }
    return const Center(
        child: Text('NO GENERATED USERS')
    );
  }

  _buildBottomBar(BuildContext context) {
    return BlocBuilder<RemoteUserBloc,RemoteUserState> (
      builder: (context,state) {
        return BottomAppBar(
          child: Row(
            children: [
              BottomButton(
                icon: RandomUserAppRoute.savedUsers.icon,
                toolTip: RandomUserAppRoute.savedUsers.name,
                onPressed: () => _onAllSavedUsersPressed(context),
              ),
              BottomButton(
                icon: Icons.save,
                toolTip: 'Save All Generated Users',
                onPressed: () => _saveAllUsers(context, state.generatedUsers!),
              ),
              BottomButton(
                icon: RandomUserAppRoute.home.icon,
                toolTip: RandomUserAppRoute.home.name,
                onPressed: () => Navigator.pushReplacementNamed(context, homeRoute),
              ),
              BottomButton(
                icon: RandomUserAppRoute.randomUserGen.icon,
                toolTip: 'Generate Single Random User',
                onPressed: () => _onGenerateRandomUsersButtonPressed(context, state, 1),
              ),
              BottomButton(
                icon: Icons.people_outline_outlined,
                toolTip: 'Generate 10 Random Users',
                onPressed: () => _onGenerateRandomUsersButtonPressed(context, state, 10),
              ),
            ],
          ),
        );
      }
    );
  }

  void _onUserPressed(BuildContext context, UserEntity user) {
    Navigator.pushReplacementNamed(context, userDetailsRoute, arguments: user);
  }

  void _onAllSavedUsersPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, savedUsersRoute);
  }

  void _onGenerateRandomUsersButtonPressed(BuildContext context, RemoteUserState state, int quantity) {
    setState(() {
      _isInit = true;
    });
    BlocProvider.of<RemoteUserBloc>(context).add(GetRandomUsers(quantity: quantity));
  }

  void _saveAllUsers(BuildContext context, List<UserEntity> users) {
    showDialog(
        context: context,
        builder: (_) => BlocBuilder<LocalUserBloc, LocalUserState>(
          builder: (context, state) {
            return Center(child: ElevatedButton(
              onPressed: () {
                for(var user in users) {
                  BlocProvider.of<LocalUserBloc>(context).add(SaveUser(user: user));
                }
                Navigator.pushReplacementNamed(context, randomUserRoute);
              },
              child: const Text('Save'),
            ));
          },
        )
    );
  }
}
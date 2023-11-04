import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

abstract class LocalUserState extends Equatable {
  final List<UserEntity>? users;

  const LocalUserState({this.users});

  @override
  List<Object> get props => [users!];
}

class LocalUserLoading extends LocalUserState {
  const LocalUserLoading();
}

class LocalUserDone extends LocalUserState {
  const LocalUserDone({super.users});
}
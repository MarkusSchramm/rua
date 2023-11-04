import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

abstract class LocalUserEvent extends Equatable {
  final UserEntity? user;

  const LocalUserEvent({this.user});

  @override
  List<Object> get props => [user!];
}

class GetSavedUsers extends LocalUserEvent {
  const GetSavedUsers();
}

class RemoveUser extends LocalUserEvent {
  const RemoveUser({super.user});
}

class RemoveAllUsers extends LocalUserEvent {
  const RemoveAllUsers();
}

class SaveUser extends LocalUserEvent {
  const SaveUser({super.user});
}
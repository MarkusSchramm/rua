import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

abstract class CustomUserEvent extends Equatable {
  final UserEntity? user;

  const CustomUserEvent(this.user);

  @override
  List<Object> get props => [user?? ''];
}

class SubmitCustomUser extends CustomUserEvent {
  const SubmitCustomUser(super.user);
}
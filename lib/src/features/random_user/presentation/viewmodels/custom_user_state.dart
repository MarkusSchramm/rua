import 'package:equatable/equatable.dart';
import 'package:rua/src/core/core.dart';

import '../../domain/entities/user_entity.dart';

abstract class CustomUserState extends Equatable {
  final UserEntity? user;

  const CustomUserState({this.user});

  @override
  List<Object> get props => [user!];
}

class CustomUserDone extends CustomUserState {
  final bool isBusy;
  final TextFieldError? emailError;
  final bool submissionSuccess;

  const CustomUserDone({
    super.user,
    this.isBusy = false,
    this.emailError,
    this.submissionSuccess = false
  });
}
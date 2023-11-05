import 'package:equatable/equatable.dart';

import 'package:rua/src/core/core.dart';

import '../../domain/entities/user_entity.dart';

class CustomUserState extends Equatable{
  final UserEntity? user;
  final TextFieldError? error;
  final TextFieldError? warning;
  final String? tag;

  const CustomUserState({this.user, this.error, this.warning, this.tag});

  @override
  List<Object> get props => [ user?? '', error?? '', warning?? '', tag?? ''];
}

class CustomUserEmpty extends CustomUserState {
  const CustomUserEmpty();
}

class InputValidation extends CustomUserState {
  const InputValidation();
}

class CustomUserDone extends CustomUserState {
  const CustomUserDone({super.user});
}

class CustomUserWarning extends CustomUserState {
  const CustomUserWarning({super.user, super.warning, super.tag});
}

class CustomUserError extends CustomUserState {
  const CustomUserError({super.error, super.tag});
}
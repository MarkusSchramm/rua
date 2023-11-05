import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rua/src/core/util/util.dart';
import 'package:rua/src/core/util/validation.dart';

import 'custom_user_event.dart';
import 'custom_user_state.dart';


class CustomUserBloc extends Bloc<CustomUserEvent, CustomUserState>
    with ValidationMixin {
  CustomUserBloc() : super(const CustomUserEmpty()) {
    on<SubmitCustomUser> (onSubmitCustomUser);
  }

  void onSubmitCustomUser(CustomUserEvent event, Emitter<CustomUserState> emit) async {
    final dataState = event.user;
    emit(const InputValidation());
    if(isFieldEmpty(dataState!.email!)) {
      emit(const CustomUserError(error: TextFieldError.empty, tag: 'Email'));
      return;
    }
    if(!validateEmailAddress(dataState.email)) {
      emit(const CustomUserError(error: TextFieldError.invalid, tag: 'Email'));
      return;
    }
    if(isFieldEmpty(dataState.firstName!)) {
      emit(CustomUserWarning(user: dataState, warning: TextFieldError.empty, tag: 'Firstname'));
      return;
    }
    if(!validateName(dataState.firstName)) {
      emit(const CustomUserError(error: TextFieldError.invalid, tag: 'Firstname'));
      return;
    }
    if(isFieldEmpty(dataState.lastName!)) {
      emit(CustomUserWarning(user: dataState, warning: TextFieldError.empty, tag: 'Lastname'));
      return;
    }
    if(!validateName(dataState.lastName)) {
      emit(const CustomUserError(error: TextFieldError.invalid, tag: 'Firstname'));
      return;
    }
    if(isFieldEmpty(dataState.phone!)) {
      emit(CustomUserWarning(user: dataState, warning: TextFieldError.empty, tag: 'Phone'));
      return;
    }
    emit(CustomUserDone(user: dataState));
  }
}
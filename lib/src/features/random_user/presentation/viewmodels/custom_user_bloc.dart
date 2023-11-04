import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rua/src/core/core.dart';
import 'package:rua/src/core/util/validation.dart';

import 'custom_user_event.dart';
import 'custom_user_state.dart';

class CustomUserBloc extends Bloc<CustomUserEvent, CustomUserState> with ValidationMixin {
  CustomUserBloc() : super(const CustomUserDone(
      user: null,
      isBusy: false,
      emailError: TextFieldError.empty,
      submissionSuccess: false
  )) {
    on<SubmitCustomUser> (onSubmitCustomUser);
  }

  void onSubmitCustomUser(SubmitCustomUser event, Emitter<CustomUserState> emit) async {
    final dataState = event;

    if(isFieldEmpty(dataState.user!.email?? '')) {
      emit(CustomUserDone(
          user: dataState.user,
          isBusy: true,
          emailError: TextFieldError.empty,
          submissionSuccess: false)
      );
    }

    if(!validateEmailAddress(dataState.user!.email?? '')) {
      emit(CustomUserDone(
          user: dataState.user,
          isBusy: true,
          emailError: TextFieldError.invalid,
          submissionSuccess: false)
      );
    }

    if(validateEmailAddress(dataState.user!.email?? '')) {
      emit(CustomUserDone(
          user: dataState.user,
          isBusy: true,
          emailError: TextFieldError.invalid,
          submissionSuccess: true)
      );
    }

  }
}
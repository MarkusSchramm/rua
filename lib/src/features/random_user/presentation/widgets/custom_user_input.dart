import 'package:flutter/material.dart';
import 'package:rua/src/features/random_user/presentation/viewmodels/custom_user_state.dart';

import '../../../../core/core.dart';
import '../../../../core/util/validation.dart';

class UserInputField extends StatelessWidget {
  final TextEditingController controller;
  final CustomUserState state;
  final String input;
  final String tag;

  const UserInputField({
    super.key,
    required this.controller,
    required this.state,
    required this.input,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
      TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: input != ''? input : tag,
        ),
      ),
      if (_hasError(state)) ...[
        const SizedBox(height: 5),
        Text(
          _errorText(state),
          style: const TextStyle(color: Colors.red),
        )],
      if (_hasWarning(state)) ...[
        const SizedBox(height: 5),
        Text(
          _warningText(state),
          style: const TextStyle(color: Colors.orange),
        )]
      ]);
  }

  bool _hasError(state) => state.error != null;

  bool _hasWarning(state) => state.warning != null;

  String _warningText(state) {
    if (state.warning != null && state.tag == tag) {
      switch (state.warning) {
        case TextFieldError.empty:
          return 'Please enter your $tag';
        case TextFieldError.invalid:
          return '$tag is invalid';
      }
    }
    return '';
  }

  String _errorText(state) {
    if (state.error != null && state.tag == tag) {
      switch (state.error) {
        case TextFieldError.empty:
          return 'Please enter your $tag';
        case TextFieldError.invalid:
          return '$tag is invalid';
      }
    }
    return '';
  }
}

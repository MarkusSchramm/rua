mixin ValidationMixin {
  String? _fieldValue;

  bool isFieldEmpty(String fieldValue) {
    _fieldValue = fieldValue;
    return _fieldValue?.isEmpty ?? true;
  }

  bool validateEmailAddress(String email) {
    _fieldValue = email;
    if (_fieldValue == null) {
      return false;
    }

    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
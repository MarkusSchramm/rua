mixin ValidationMixin {
  late String _fieldValue;

  bool isFieldEmpty(String fieldValue) {
    _fieldValue = fieldValue;
    return _fieldValue.isEmpty;
  }

  bool validateName(String? name) {
    if (name == null) {
      return false;
    }
    _fieldValue = name;
    return RegExp(
        r'(^[a-zA-ZäöüßÄÖÜ]+$)')
        .hasMatch(name);
  }

  bool validateDay(String? day) {
    if (day == null) {
      return false;
    }
    _fieldValue = day;
    if(RegExp(r'(^[0-9]+$)').hasMatch(day)){
      int val = int.parse(_fieldValue);
      if(val > 31) return false;
      if(val < 0) return false;
    } else {
      return true;
    }
    return false;
  }

  bool validateMonth(String? month) {
    if (month == null) {
      return false;
    }
    _fieldValue = month;
    if(RegExp(r'(^[0-9]+$)').hasMatch(month)){
      int val = int.parse(_fieldValue);
      if(val > 12) return false;
      if(val < 0) return false;
    } else {
      return true;
    }
    return false;
  }

  bool validateYear(String? year) {
    if (year == null) {
      return false;
    }
    _fieldValue = year;
    if(RegExp(r'(^[0-9]+$)').hasMatch(year)){
      int val = int.parse(_fieldValue);
      if(val > 2050) return false;
      if(val < 0) return false;
    } else {
      return true;
    }
    return false;
  }

  bool validateEmailAddress(String? email) {
    if (email == null) {
      return false;
    }
    _fieldValue = email;
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
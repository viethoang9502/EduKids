import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../res/enum/validate_state.dart';

extension StringExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() =>
      replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

class StringUtils {
  static bool isEmpty(String? s) {
    if (s == null) return true;
    if (s.trim().isEmpty) return true;
    return false;
  }

  static bool nullOrEmpty(dynamic value) {
    if (value == null ||
        value.toString().isEmpty ||
        value.toString() == 'null' ||
        (value is List && value.isEmpty == true)) return true;
    return false;
  }

  //InvalidPhoneState
  static String toInvalidPhoneString(ValidatePhoneState state, BuildContext context) {
    switch (state) {
      case ValidatePhoneState.invalid:
        return "Lỗi số điện thoại";
      case ValidatePhoneState.notCorrect:
        return "Không tìm thấy số điện thoại";
      case ValidatePhoneState.none:
      default:
        return "";
    }
  }
static String toInvalidPasswordString(
      ValidatePasswordState state, BuildContext context) {
    switch (state) {
      case ValidatePasswordState.invalid:
        return "Mật khẩu không hợp lệ";
      // case ValidatePasswordState.notMatched:
      //   return "Mật khẩu không trùng khớp";
      // case ValidatePasswordState.notNewPassword:
      //   return "Mật khẩu mới trùng mật khẩu cũ";
      // case ValidatePasswordState.short:
      //   return Strings.of(context).passShort;
      // case ValidatePasswordState.noEmpty:
      //   return Strings.of(context).emptyPassword;
      // case ValidatePasswordState.inEmpty:
      //   return Strings.of(context).noEmptyPasswordNew;
      // case ValidatePasswordState.passNewCorrect:
      //   return Strings.of(context).passNewNotMatch;
      // case ValidatePasswordState.passOldCorrect:
      //   return Strings.of(context).oldPasswordNoCorrect;
      // case ValidatePasswordState.none:
      default:
        return "";
    }
  }

  //InvalidEmailState
  static String toInvalidEmailString(ValidateEmailState state, BuildContext context) {
    switch (state) {
      case ValidateEmailState.invalid:
        return "Email bị lỗi";
      case ValidateEmailState.notCorrect:
        return "Không tìm thấy email";
      case ValidateEmailState.none:
      default:
        return "";
    }
  }

  //InvalidlState
  static String toErrorString(ValidateState state) {
    switch (state) {
      case ValidateState.invalid:
        return "Giá trị không hợp lệ";
      case ValidateState.none:
      default:
        return "";
    }
  }

  //ValidateOTPState
  static String toInvalidOTPString(ValidateOTPState state) {
    switch (state) {
      case ValidateOTPState.invalid:
        return "Invalid OTP";
      case ValidateOTPState.notCorrect:
        return "OTP not correct";
      case ValidateOTPState.none:
      default:
        return "";
    }
  }

  //InvalidEmailState
  // static String toInvalidPasswordString(
  //     ValidatePasswordState state, BuildContext context) {
  //   switch (state) {
  //     case ValidatePasswordState.invalid:
  //       return Strings.of(context).invalidPass;
  //     case ValidatePasswordState.notCorrect:
  //       return Strings.of(context).passNotMatch;
  //     case ValidatePasswordState.short:
  //       return Strings.of(context).passShort;
  //     case ValidatePasswordState.noEmpty:
  //       return Strings.of(context).emptyPassword;
  //     case ValidatePasswordState.inEmpty:
  //       return Strings.of(context).noEmptyPasswordNew;
  //     case ValidatePasswordState.passNewCorrect:
  //       return Strings.of(context).passNewNotMatch;
  //     case ValidatePasswordState.passOldCorrect:
  //       return Strings.of(context).oldPasswordNoCorrect;
  //     case ValidatePasswordState.none:
  //     default:
  //       return Constants.EMPTY_STRING;
  //   }
  // }

  static String toNumberOfTaskString(int numberOfTask) {
    if (numberOfTask == 0) return "0";
    if (numberOfTask < 10) return "0$numberOfTask";
    return "$numberOfTask";
  }

  static bool isValidNumberFormat(String value) {
    value = value.replaceAll(RegExp(r'/[^0-9.-]+/g'), "");
    try {
      num.parse(value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isValidPasswordFormat(String value) {
    value = value.replaceAll(
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$'), "");
    return true;
  }

  static String toErrorTimeString(CompareTimeState state) {
    switch (state) {
      case CompareTimeState.invalid:
        return "Thời gian không hợp lệ!";
      case CompareTimeState.none:
      default:
        return "";
    }
  }

  static String toErrorPriceString(ValidateState state) {
    switch (state) {
      case ValidateState.invalid:
        return "Giá sale phải nhỏ hơn giá bán!";
      case ValidateState.none:
      default:
        return "";
    }
  }

  static String getDateString(String dateStr) {
    final DateTime date = DateTime.parse(dateStr);
    return "${date.year}/${_twoDigits(date.month)}/${_twoDigits(date.day)}";
  }

  static String getTimeString(String dateStr) {
    final DateTime date = DateTime.parse(dateStr);
    return DateFormat('hh:mm a').format(date);
  }

  static String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
}

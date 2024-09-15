import 'package:intl/intl.dart';

class Validators {
  Validators._();

  static bool isEmpty(String? s) {
    if (s == null) return true;
    return s == "";
  }

  static bool isEmail(String email) {
    if (isEmpty(email)) {
      return false;
    }

    final emailRegexp =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegexp.hasMatch(email);
  }

  static bool isSpecialChartPassword(String password) {
    if (isEmpty(password)) {
      return false;
    }
    final validCharacters = RegExp(r'^[a-zA-Z0-9@]+$');
    return validCharacters.hasMatch(password);
  }

  static bool isValidPassword(String password) {
    if (isEmpty(password)) {
      return false;
    }

    if (password.length < 6) {
      return password.length >= 6;
    }

    final passRegexp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$');

    return passRegexp.hasMatch(password) && password.length >= 6;

    // final RegExp passwordRegexp =
    //     RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
    // final RegExp passwordRegexp = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$");
    // final RegExp passwordRegexp = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$");
    // return passwordRegexp.hasMatch(password) &&
    //     password.length > Constants.MINIMUM_PASSWORD_LENGTH;
    // return password.length >= Constants.MINIMUM_PASSWORD_LENGTH;
  }

  static bool isValidPhone(String phone) {
    if (isEmpty(phone)) {
      return false;
    }
    return phone.length >= 10;
  }
  static String formatCurrency(double amount) {
  final format = NumberFormat("#,##0", "vi_VN");
  return "${format.format(amount)} ";
}
}

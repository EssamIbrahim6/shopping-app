import 'package:shopping_app/core/constants/app_key.dart';
import 'package:shopping_app/core/constants/app_strings.dart';

abstract class Validator {
  static String? validateEmail(String? val) {
    final RegExp emailRegex = RegExp(AppKeys.emailRegex);
    if (val == null || val.trim().isEmpty) {
      return AppStrings.emailCannotBeEmpty;
    } else if (!emailRegex.hasMatch(val)) {
      return AppStrings.invalidEmail;
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    final RegExp passwordRegex = RegExp(AppKeys.passwordRegex);
    if (val == null || val.isEmpty) {
      return AppStrings.passwordCannotBeEmpty;
    } else if (!passwordRegex.hasMatch(val)) {
      return AppStrings.invalidPassword;
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return AppStrings.passwordCannotBeEmpty;
    } else if (val != password) {
      return AppStrings.confirmPasswordNotMatch;
    } else {
      return null;
    }
  }

  static String? validateName(String? val) {
    if (val == null || val.isEmpty) {
      return AppStrings.nameCannotBeEmpty;
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null || val.trim().isEmpty) {
      return AppStrings.phoneCannotBeEmpty;
    }

    final phone = val.trim();
    final isValid = RegExp(r'^01[0125]\d{8}$').hasMatch(phone);
    if (!isValid) {
      return AppStrings.invalidPhoneNumber;
    }

    return null;
  }

  static String? validateCode(String? val) {
    if (val == null || val.isEmpty) {
      return AppStrings.codeCannotBeEmpty;
    } else if (val.length < 6) {
      return AppStrings.invalidCode;
    } else {
      return null;
    }
  }
}

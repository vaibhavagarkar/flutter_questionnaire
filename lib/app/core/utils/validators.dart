import '../constants/app_strings.dart';

class Validators {
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.phoneRequired;
    }

    final phone = value.trim();
    if (!RegExp(r'^\d{10}$').hasMatch(phone)) {
      return AppStrings.invalidPhone;
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }

    if (value.length < 6) {
      return AppStrings.passwordMinLength;
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (password.isEmpty) {
      return AppStrings.passwordRequiredFirst;
    }

    if (value != password) {
      return AppStrings.passwordsDoNotMatch;
    }

    return null;
  }
}

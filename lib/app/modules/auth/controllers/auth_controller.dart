import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../domain/models/app_user.dart';
import '../../../domain/usecases/check_phone_exists_use_case.dart';
import '../../../domain/usecases/clear_user_session_use_case.dart';
import '../../../domain/usecases/login_user_use_case.dart';
import '../../../domain/usecases/register_user_use_case.dart';
import '../../../domain/usecases/restore_user_session_use_case.dart';
import '../../../domain/usecases/save_user_session_use_case.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  AuthController({
    required CheckPhoneExistsUseCase checkPhoneExists,
    required RegisterUserUseCase registerUser,
    required LoginUserUseCase loginUser,
    required RestoreUserSessionUseCase restoreUserSession,
    required SaveUserSessionUseCase saveUserSession,
    required ClearUserSessionUseCase clearUserSession,
  }) : _checkPhoneExists = checkPhoneExists,
       _registerUser = registerUser,
       _loginUser = loginUser,
       _restoreUserSession = restoreUserSession,
       _saveUserSession = saveUserSession,
       _clearUserSession = clearUserSession;

  final CheckPhoneExistsUseCase _checkPhoneExists;
  final RegisterUserUseCase _registerUser;
  final LoginUserUseCase _loginUser;
  final RestoreUserSessionUseCase _restoreUserSession;
  final SaveUserSessionUseCase _saveUserSession;
  final ClearUserSessionUseCase _clearUserSession;

  final registerFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();

  final registerPhoneController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  final loginPhoneController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final _isRegistering = false.obs;
  final _isLoggingIn = false.obs;
  final _currentUser = Rxn<AppUser>();
  final _isLoginPasswordVisible = false.obs;
  final _isRegisterPasswordVisible = false.obs;
  final _isRegisterConfirmPasswordVisible = false.obs;

  bool get isRegistering => _isRegistering.value;
  bool get isLoggingIn => _isLoggingIn.value;
  bool get isLoggedIn => _currentUser.value != null;
  bool get isLoginPasswordVisible => _isLoginPasswordVisible.value;
  bool get isRegisterPasswordVisible => _isRegisterPasswordVisible.value;
  bool get isRegisterConfirmPasswordVisible =>
      _isRegisterConfirmPasswordVisible.value;
  AppUser? get currentUser => _currentUser.value;

  void clearLoginFields() {
    loginPhoneController.clear();
    loginPasswordController.clear();
    _isLoginPasswordVisible.value = false;
  }

  void clearRegisterFields() {
    registerPhoneController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
    _isRegisterPasswordVisible.value = false;
    _isRegisterConfirmPasswordVisible.value = false;
  }

  void toggleLoginPasswordVisibility() {
    _isLoginPasswordVisible.toggle();
  }

  void toggleRegisterPasswordVisibility() {
    _isRegisterPasswordVisible.toggle();
  }

  void toggleRegisterConfirmPasswordVisibility() {
    _isRegisterConfirmPasswordVisible.toggle();
  }

  Future<void> restoreSession() async {
    _currentUser.value = await _restoreUserSession();
  }

  Future<void> register() async {
    final formState = registerFormKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    final phone = registerPhoneController.text.trim();
    final password = registerPasswordController.text.trim();

    _isRegistering.value = true;
    try {
      if (await _checkPhoneExists(phone)) {
        Get.snackbar(
          AppStrings.registrationFailed,
          AppStrings.phoneAlreadyExists,
        );
        return;
      }

      await _registerUser(phone: phone, password: password);
      clearRegisterFields();
      clearLoginFields();
      Get.snackbar(AppStrings.accountCreated, AppStrings.accountCreatedMessage);
      await Get.offNamed(AppRoutes.login);
    } finally {
      _isRegistering.value = false;
    }
  }

  Future<void> login() async {
    final formState = loginFormKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    _isLoggingIn.value = true;
    try {
      final user = await _loginUser(
        phone: loginPhoneController.text.trim(),
        password: loginPasswordController.text.trim(),
      );

      if (user == null || user.id == null) {
        Get.snackbar(AppStrings.loginFailed, AppStrings.invalidPhoneOrPassword);
        return;
      }

      _currentUser.value = user;
      await _saveUserSession(user.id!);
      clearLoginFields();
      await Get.offAllNamed(AppRoutes.home);
    } finally {
      _isLoggingIn.value = false;
    }
  }

  Future<void> logout() async {
    await _clearUserSession();
    _currentUser.value = null;
    clearLoginFields();
    clearRegisterFields();
    await Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    registerPhoneController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    loginPhoneController.dispose();
    loginPasswordController.dispose();
    super.onClose();
  }
}

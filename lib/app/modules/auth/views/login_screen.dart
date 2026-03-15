import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_card.dart';
import '../../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: SectionCard(
                child: Form(
                  key: controller.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.welcomeBack,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.loginSubtitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: controller.loginPhoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        maxLength: 10,
                        decoration: const InputDecoration(
                          labelText: AppStrings.phone,
                          prefixText: '${AppStrings.countryCodeIndia} ',
                          counterText: '',
                        ),
                        validator: Validators.phone,
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => TextFormField(
                          controller: controller.loginPasswordController,
                          obscureText: !controller.isLoginPasswordVisible,
                          decoration: InputDecoration(
                            labelText: AppStrings.password,
                            suffixIcon: IconButton(
                              onPressed:
                                  controller.toggleLoginPasswordVisibility,
                              icon: Icon(
                                controller.isLoginPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                          ),
                          validator: Validators.password,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Obx(
                        () => PrimaryButton(
                          label: AppStrings.login,
                          isLoading: controller.isLoggingIn,
                          onPressed: controller.login,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        child: TextButton(
                          onPressed: () {
                            controller.clearLoginFields();
                            controller.clearRegisterFields();
                            Get.toNamed(AppRoutes.register);
                          },
                          child: const Text(AppStrings.createAnAccount),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

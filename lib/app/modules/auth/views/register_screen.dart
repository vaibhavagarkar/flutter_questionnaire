import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_card.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.createAccount),
        leading: IconButton(
          onPressed: () {
            controller.clearRegisterFields();
            controller.clearLoginFields();
            Get.back<void>();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: SectionCard(
                child: Form(
                  key: controller.registerFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.register,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.registerSubtitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: controller.registerPhoneController,
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
                          controller: controller.registerPasswordController,
                          obscureText: !controller.isRegisterPasswordVisible,
                          decoration: InputDecoration(
                            labelText: AppStrings.password,
                            suffixIcon: IconButton(
                              onPressed:
                                  controller.toggleRegisterPasswordVisibility,
                              icon: Icon(
                                controller.isRegisterPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                          ),
                          validator: Validators.password,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => TextFormField(
                          controller:
                              controller.registerConfirmPasswordController,
                          obscureText:
                              !controller.isRegisterConfirmPasswordVisible,
                          decoration: InputDecoration(
                            labelText: AppStrings.confirmPassword,
                            suffixIcon: IconButton(
                              onPressed: controller
                                  .toggleRegisterConfirmPasswordVisibility,
                              icon: Icon(
                                controller.isRegisterConfirmPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                          ),
                          validator: (value) => Validators.confirmPassword(
                            value,
                            controller.registerPasswordController.text.trim(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Obx(
                        () => PrimaryButton(
                          label: AppStrings.register,
                          isLoading: controller.isRegistering,
                          onPressed: controller.register,
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

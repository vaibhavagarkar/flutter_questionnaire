import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/utils/date_time_formatter.dart';
import '../../../core/widgets/section_card.dart';
import '../../auth/controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.profile)),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.userDetails,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text('${AppStrings.phoneLabelPrefix}${controller.phone}'),
                  const SizedBox(height: 8),
                  Text(
                    '${AppStrings.totalQuestionnairesFilledPrefix}${controller.submissionCount.value}',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.submissionHistory,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  if (controller.isLoading.value)
                    const Center(child: CircularProgressIndicator())
                  else if (controller.submissions.isEmpty)
                    const Text(AppStrings.noQuestionnaireSubmissionsYet)
                  else
                    ...controller.submissions.map(
                      (submission) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(submission.questionnaireTitle),
                        subtitle: Text(formatDateTime(submission.submittedAt)),
                        trailing: Text(
                          '${AppStrings.latitudeLabel}${submission.latitude}\n'
                          '${AppStrings.longitudeLabel}${submission.longitude}',
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: authController.logout,
              child: const Text(AppStrings.logout),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/utils/date_time_formatter.dart';
import '../../../core/widgets/section_card.dart';
import '../../../routes/app_routes.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.questionnaires),
        actions: [
          IconButton(
            onPressed: () async {
              await Get.toNamed(AppRoutes.profile);
              await controller.loadData();
            },
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.questionnaires.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.loadData,
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: controller.questionnaires.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = controller.questionnaires[index];
              final count = controller.submissionCounts[item.id] ?? 0;
              final latestDate = controller.latestSubmissionDates[item.id];

              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () async {
                  final result = await Get.toNamed(
                    AppRoutes.questionnaire,
                    arguments: item,
                  );
                  if (result == true) {
                    Get.snackbar(
                      AppStrings.submitted,
                      AppStrings.questionnaireSavedLocally,
                    );
                    await controller.loadData();
                  }
                },
                child: SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(item.description),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          Chip(
                            label: Text(
                              '$count${AppStrings.submissionsSuffix}',
                            ),
                          ),
                          Chip(
                            label: Text(
                              latestDate == null
                                  ? AppStrings.noSubmissionsYet
                                  : '${AppStrings.lastPrefix}${formatDateTime(latestDate)}',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

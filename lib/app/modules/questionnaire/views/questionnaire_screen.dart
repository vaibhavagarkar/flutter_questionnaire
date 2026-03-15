import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_card.dart';
import '../controllers/questionnaire_controller.dart';

class QuestionnaireScreen extends GetView<QuestionnaireController> {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.questionnaire.title)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: controller.questionnaire.questions.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final question = controller.questionnaire.questions[index];

                  return SectionCard(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Q${index + 1}. ${question.text}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          ...question.options.map(
                            (option) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: ChoiceChip(
                                label: Text(option),
                                selected:
                                    controller.selectedAnswers[question.id] ==
                                    option,
                                onSelected: (_) {
                                  controller.selectAnswer(
                                    questionId: question.id,
                                    answer: option,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Obx(
                () => PrimaryButton(
                  label: AppStrings.submitResponse,
                  isLoading: controller.isSubmitting.value,
                  onPressed: controller.submit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

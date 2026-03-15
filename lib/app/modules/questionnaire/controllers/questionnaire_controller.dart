import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../domain/models/questionnaire.dart';
import '../../../domain/models/questionnaire_submission.dart';
import '../../../domain/services/location_service_contract.dart';
import '../../../domain/usecases/save_questionnaire_submission_use_case.dart';
import '../../auth/controllers/auth_controller.dart';

class QuestionnaireController extends GetxController {
  QuestionnaireController({
    required AuthController authController,
    required SaveQuestionnaireSubmissionUseCase saveQuestionnaireSubmission,
    required LocationServiceContract locationService,
    required this.questionnaire,
  }) : _authController = authController,
       _saveQuestionnaireSubmission = saveQuestionnaireSubmission,
       _locationService = locationService;

  final AuthController _authController;
  final SaveQuestionnaireSubmissionUseCase _saveQuestionnaireSubmission;
  final LocationServiceContract _locationService;
  final Questionnaire questionnaire;

  final selectedAnswers = <String, String>{}.obs;
  final isSubmitting = false.obs;

  bool get canSubmit =>
      selectedAnswers.length == questionnaire.questions.length;

  void selectAnswer({required String questionId, required String answer}) {
    selectedAnswers[questionId] = answer;
  }

  Future<void> submit() async {
    final user = _authController.currentUser;
    if (user?.id == null) {
      Get.snackbar(AppStrings.sessionExpired, AppStrings.pleaseLoginAgain);
      return;
    }

    if (!canSubmit) {
      Get.snackbar(
        AppStrings.incompleteQuestionnaire,
        AppStrings.answerAllQuestions,
      );
      return;
    }

    isSubmitting.value = true;
    try {
      final location = await _locationService.determineLocation();

      // Save the full response we need for offline history.
      final submission = QuestionnaireSubmission(
        userId: user!.id!,
        questionnaireId: questionnaire.id,
        questionnaireTitle: questionnaire.title,
        answers: Map<String, String>.from(selectedAnswers),
        submittedAt: DateTime.now(),
        latitude: location.latitude,
        longitude: location.longitude,
      );

      await _saveQuestionnaireSubmission(submission);
      Get.back<bool>(result: true);
    } catch (error) {
      Get.snackbar(AppStrings.submissionFailed, error.toString());
    } finally {
      isSubmitting.value = false;
    }
  }
}

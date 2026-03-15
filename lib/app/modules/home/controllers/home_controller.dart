import 'package:get/get.dart';

import '../../../domain/models/questionnaire.dart';
import '../../../domain/models/questionnaire_submission.dart';
import '../../../domain/usecases/get_questionnaires_use_case.dart';
import '../../../domain/usecases/get_user_submissions_use_case.dart';
import '../../auth/controllers/auth_controller.dart';

class HomeController extends GetxController {
  HomeController({
    required GetQuestionnairesUseCase getQuestionnaires,
    required GetUserSubmissionsUseCase getUserSubmissions,
  }) : _getQuestionnaires = getQuestionnaires,
       _getUserSubmissions = getUserSubmissions;

  final GetQuestionnairesUseCase _getQuestionnaires;
  final GetUserSubmissionsUseCase _getUserSubmissions;
  final AuthController _authController = Get.find<AuthController>();

  final questionnaires = <Questionnaire>[].obs;
  final submissionCounts = <String, int>{}.obs;
  final latestSubmissionDates = <String, DateTime>{}.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    final user = _authController.currentUser;
    if (user?.id == null) {
      return;
    }

    isLoading.value = true;
    try {
      questionnaires.assignAll(await _getQuestionnaires());
      final submissions = await _getUserSubmissions(user!.id!);
      _buildSubmissionState(submissions);
    } finally {
      isLoading.value = false;
    }
  }

  void _buildSubmissionState(List<QuestionnaireSubmission> submissions) {
    final counts = <String, int>{};
    final latestDates = <String, DateTime>{};

    for (final submission in submissions) {
      counts.update(
        submission.questionnaireId,
        (value) => value + 1,
        ifAbsent: () => 1,
      );

      final existingDate = latestDates[submission.questionnaireId];
      if (existingDate == null ||
          submission.submittedAt.isAfter(existingDate)) {
        latestDates[submission.questionnaireId] = submission.submittedAt;
      }
    }

    submissionCounts.assignAll(counts);
    latestSubmissionDates.assignAll(latestDates);
  }
}

import 'package:get/get.dart';

import '../../../domain/models/questionnaire_submission.dart';
import '../../../domain/usecases/get_user_submissions_use_case.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  ProfileController({
    required AuthController authController,
    required GetUserSubmissionsUseCase getUserSubmissions,
  }) : _authController = authController,
       _getUserSubmissions = getUserSubmissions;

  final AuthController _authController;
  final GetUserSubmissionsUseCase _getUserSubmissions;

  final submissions = <QuestionnaireSubmission>[].obs;
  final isLoading = false.obs;
  final submissionCount = 0.obs;

  String get phone => _authController.currentUser?.phone ?? '-';

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final user = _authController.currentUser;
    if (user?.id == null) {
      return;
    }

    isLoading.value = true;
    try {
      final items = await _getUserSubmissions(user!.id!);
      submissions.assignAll(items);
      submissionCount.value = items.length;
    } finally {
      isLoading.value = false;
    }
  }
}

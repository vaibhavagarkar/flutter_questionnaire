import '../models/questionnaire_submission.dart';

abstract class SubmissionRepositoryContract {
  Future<void> saveSubmission(QuestionnaireSubmission submission);

  Future<List<QuestionnaireSubmission>> fetchSubmissionsForUser(int userId);

  Future<int> countForUser(int userId);
}

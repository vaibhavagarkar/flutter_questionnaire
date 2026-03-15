import '../models/questionnaire_submission.dart';
import '../repositories/submission_repository_contract.dart';

class SaveQuestionnaireSubmissionUseCase {
  const SaveQuestionnaireSubmissionUseCase(this._repository);

  final SubmissionRepositoryContract _repository;

  Future<void> call(QuestionnaireSubmission submission) {
    return _repository.saveSubmission(submission);
  }
}

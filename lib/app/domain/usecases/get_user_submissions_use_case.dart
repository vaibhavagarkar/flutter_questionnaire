import '../models/questionnaire_submission.dart';
import '../repositories/submission_repository_contract.dart';

class GetUserSubmissionsUseCase {
  const GetUserSubmissionsUseCase(this._repository);

  final SubmissionRepositoryContract _repository;

  Future<List<QuestionnaireSubmission>> call(int userId) {
    return _repository.fetchSubmissionsForUser(userId);
  }
}

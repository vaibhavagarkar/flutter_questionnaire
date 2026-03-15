import '../models/questionnaire.dart';
import '../repositories/questionnaire_repository_contract.dart';

class GetQuestionnairesUseCase {
  const GetQuestionnairesUseCase(this._repository);

  final QuestionnaireRepositoryContract _repository;

  Future<List<Questionnaire>> call() {
    return _repository.fetchQuestionnaires();
  }
}

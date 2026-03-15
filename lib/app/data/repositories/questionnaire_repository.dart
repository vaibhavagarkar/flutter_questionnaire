import '../../domain/models/questionnaire.dart';
import '../../domain/repositories/questionnaire_repository_contract.dart';
import '../datasources/mock_questionnaire_data_source.dart';

class QuestionnaireRepository implements QuestionnaireRepositoryContract {
  QuestionnaireRepository(this._dataSource);

  final MockQuestionnaireDataSource _dataSource;

  @override
  Future<List<Questionnaire>> fetchQuestionnaires() {
    return _dataSource.fetchQuestionnaires();
  }
}

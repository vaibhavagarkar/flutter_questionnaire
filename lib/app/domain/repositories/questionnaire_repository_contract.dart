import '../models/questionnaire.dart';

abstract class QuestionnaireRepositoryContract {
  Future<List<Questionnaire>> fetchQuestionnaires();
}

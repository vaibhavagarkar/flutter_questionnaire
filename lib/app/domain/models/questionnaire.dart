import 'question.dart';

class Questionnaire {
  const Questionnaire({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });

  final String id;
  final String title;
  final String description;
  final List<Question> questions;
}

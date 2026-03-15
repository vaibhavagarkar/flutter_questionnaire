import 'dart:convert';

class QuestionnaireSubmission {
  const QuestionnaireSubmission({
    this.id,
    required this.userId,
    required this.questionnaireId,
    required this.questionnaireTitle,
    required this.answers,
    required this.submittedAt,
    required this.latitude,
    required this.longitude,
  });

  final int? id;
  final int userId;
  final String questionnaireId;
  final String questionnaireTitle;
  final Map<String, String> answers;
  final DateTime submittedAt;
  final double latitude;
  final double longitude;

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'questionnaire_id': questionnaireId,
      'questionnaire_title': questionnaireTitle,
      'answers_json': jsonEncode(answers),
      'submitted_at': submittedAt.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory QuestionnaireSubmission.fromMap(Map<String, Object?> map) {
    return QuestionnaireSubmission(
      id: map['id'] as int?,
      userId: map['user_id'] as int,
      questionnaireId: map['questionnaire_id'] as String,
      questionnaireTitle: map['questionnaire_title'] as String,
      answers: Map<String, String>.from(
        jsonDecode(map['answers_json'] as String) as Map<String, dynamic>,
      ),
      submittedAt: DateTime.parse(map['submitted_at'] as String),
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
    );
  }
}

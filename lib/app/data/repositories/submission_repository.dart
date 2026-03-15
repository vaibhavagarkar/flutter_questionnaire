import '../../domain/models/questionnaire_submission.dart';
import '../../domain/repositories/submission_repository_contract.dart';
import '../local/app_database_service.dart';

class SubmissionRepository implements SubmissionRepositoryContract {
  SubmissionRepository(this._databaseService);

  final AppDatabaseService _databaseService;

  @override
  Future<void> saveSubmission(QuestionnaireSubmission submission) async {
    await _databaseService.database.insert('submissions', submission.toMap());
  }

  @override
  Future<List<QuestionnaireSubmission>> fetchSubmissionsForUser(
    int userId,
  ) async {
    final results = await _databaseService.database.query(
      'submissions',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'submitted_at DESC',
    );

    return results.map(QuestionnaireSubmission.fromMap).toList();
  }

  @override
  Future<int> countForUser(int userId) async {
    final results = await _databaseService.database.rawQuery(
      'SELECT COUNT(*) AS total FROM submissions WHERE user_id = ?',
      [userId],
    );

    return (results.first['total'] as int?) ?? 0;
  }
}

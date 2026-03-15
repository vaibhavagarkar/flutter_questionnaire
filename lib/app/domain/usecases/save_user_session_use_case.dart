import '../../data/local/session_service.dart';

class SaveUserSessionUseCase {
  const SaveUserSessionUseCase(this._sessionService);

  final SessionService _sessionService;

  Future<void> call(int userId) {
    return _sessionService.saveUserId(userId);
  }
}

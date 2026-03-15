import '../../data/local/session_service.dart';

class ClearUserSessionUseCase {
  const ClearUserSessionUseCase(this._sessionService);

  final SessionService _sessionService;

  Future<void> call() {
    return _sessionService.clear();
  }
}

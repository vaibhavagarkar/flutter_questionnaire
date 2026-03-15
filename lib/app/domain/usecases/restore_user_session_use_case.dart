import '../../data/local/session_service.dart';
import '../models/app_user.dart';
import '../repositories/auth_repository_contract.dart';

class RestoreUserSessionUseCase {
  const RestoreUserSessionUseCase({
    required AuthRepositoryContract authRepository,
    required SessionService sessionService,
  }) : _authRepository = authRepository,
       _sessionService = sessionService;

  final AuthRepositoryContract _authRepository;
  final SessionService _sessionService;

  Future<AppUser?> call() async {
    // Shared preferences keeps only the user id, so load the full user here.
    final userId = _sessionService.currentUserId;
    if (userId == null) {
      return null;
    }

    return _authRepository.getUserById(userId);
  }
}

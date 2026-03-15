import '../models/app_user.dart';
import '../repositories/auth_repository_contract.dart';

class LoginUserUseCase {
  const LoginUserUseCase(this._repository);

  final AuthRepositoryContract _repository;

  Future<AppUser?> call({required String phone, required String password}) {
    return _repository.login(phone: phone, password: password);
  }
}

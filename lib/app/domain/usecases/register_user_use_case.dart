import '../models/app_user.dart';
import '../repositories/auth_repository_contract.dart';

class RegisterUserUseCase {
  const RegisterUserUseCase(this._repository);

  final AuthRepositoryContract _repository;

  Future<AppUser> call({required String phone, required String password}) {
    return _repository.register(phone: phone, password: password);
  }
}

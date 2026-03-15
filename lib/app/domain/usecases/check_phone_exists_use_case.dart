import '../repositories/auth_repository_contract.dart';

class CheckPhoneExistsUseCase {
  const CheckPhoneExistsUseCase(this._repository);

  final AuthRepositoryContract _repository;

  Future<bool> call(String phone) {
    return _repository.phoneExists(phone);
  }
}

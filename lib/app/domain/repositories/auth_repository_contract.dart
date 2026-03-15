import '../models/app_user.dart';

abstract class AuthRepositoryContract {
  Future<bool> phoneExists(String phone);

  Future<AppUser> register({required String phone, required String password});

  Future<AppUser?> login({required String phone, required String password});

  Future<AppUser?> getUserById(int id);
}

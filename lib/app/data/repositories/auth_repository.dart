import '../../domain/models/app_user.dart';
import '../../domain/repositories/auth_repository_contract.dart';
import '../local/app_database_service.dart';

class AuthRepository implements AuthRepositoryContract {
  AuthRepository(this._databaseService);

  final AppDatabaseService _databaseService;

  @override
  Future<bool> phoneExists(String phone) async {
    final results = await _databaseService.database.query(
      'users',
      columns: ['id'],
      where: 'phone = ?',
      whereArgs: [phone],
      limit: 1,
    );

    return results.isNotEmpty;
  }

  @override
  Future<AppUser> register({
    required String phone,
    required String password,
  }) async {
    final id = await _databaseService.database.insert('users', {
      'phone': phone,
      'password': password,
    });

    return AppUser(id: id, phone: phone, password: password);
  }

  @override
  Future<AppUser?> login({
    required String phone,
    required String password,
  }) async {
    final results = await _databaseService.database.query(
      'users',
      where: 'phone = ? AND password = ?',
      whereArgs: [phone, password],
      limit: 1,
    );

    if (results.isEmpty) {
      return null;
    }

    return AppUser.fromMap(results.first);
  }

  @override
  Future<AppUser?> getUserById(int id) async {
    final results = await _databaseService.database.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isEmpty) {
      return null;
    }

    return AppUser.fromMap(results.first);
  }
}

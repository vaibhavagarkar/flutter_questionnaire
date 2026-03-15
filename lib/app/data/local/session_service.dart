import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const _userIdKey = 'current_user_id';
  late final SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  int? get currentUserId => _preferences.getInt(_userIdKey);

  Future<void> saveUserId(int userId) async {
    await _preferences.setInt(_userIdKey, userId);
  }

  Future<void> clear() async {
    await _preferences.remove(_userIdKey);
  }
}

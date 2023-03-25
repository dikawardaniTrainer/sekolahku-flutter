import 'package:sekolah_ku/resources/string_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserPref {
  Future<void> save(String token);
  Future<void> clear();
  Future<String?> getToken();
}

class UserPrefImpl extends UserPref {
  final _keySession = "TOKEN";
  Future<SharedPreferences> get _sharedPref => SharedPreferences.getInstance();

  @override
  Future<void> save(String token) async => (await _sharedPref).setString(_keySession, token);

  @override
  Future<void> clear() async => (await _sharedPref).setString(_keySession, StringRes.emptyString);

  @override
  Future<String?> getToken() async {
    final savedToken = (await _sharedPref).getString(_keySession);
    if (savedToken != null) {
      return savedToken.isNotEmpty ? savedToken: null;
    }
    return null;
  }
}

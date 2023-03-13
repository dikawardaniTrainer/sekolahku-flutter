import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../repository/user_repository.dart';

class UserService {
  String keySession = "TOKEN";
  final UserRepository _userRepository;

  UserService(this._userRepository);

  Future<void> _saveSession(String token) {
    return Future(() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(keySession, token);
    });
  }

  Future<void> _clearSession() {
    return Future(() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(keySession, "");
    });
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(keySession);
    bool loggedIn = false;

    if (token != null && token.isNotEmpty) {
      loggedIn = true;
    }

    return Future.value(loggedIn);
  }

  Future<User> login(String username, String password, Role role) {
    return Future(() async {
      final found = await _userRepository.findByNameAndPassword(username, password, role.id);
      if (found != null) {
        _saveSession(username);
        return Future.value(found);
      }
      throw Exception("Username or password are wrong");
    });
  }

  Future<void> logout() async {
    return Future(() async {
      if (!await isLoggedIn()) {
      throw Exception("No user has been logged in");
      }
      _clearSession();
    });
  }

  Future<List<Role>> getRoles() => _userRepository.getRoles();
}
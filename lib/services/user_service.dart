import 'package:sekolah_ku/model/user.dart';
import 'package:sekolah_ku/pref/user_pref.dart';
import 'package:sekolah_ku/repository/user_repository.dart';
import 'package:sekolah_ku/util/logger.dart';

class UserService {
  final UserRepository _userRepository;
  final UserPref _userPref;

  UserService(
      this._userRepository,
      this._userPref
  );

  Future<void> _saveSession(String token) async {
    debugAction("Save session", "Saving session for token : $token");
    await _userPref.save(token);
    debugAction("Save session", "Session saved");
  }

  Future<void> _clearSession() async {
    await _userPref.clear();
    debugAction("Clear session", "Session cleared");
  }

  Future<bool> isLoggedIn() async {
    final savedToken = await _userPref.getToken();
    debugAction("Is logged in", "Saved token : $savedToken");
    final isLoggedIn = savedToken != null;
    debugAction("Is logged in", "Already logged in ? $isLoggedIn");
    return isLoggedIn;
  }

  Future<User> login(String username, String password, Role role) async {
    debugAction("Login", "Get user for username: $username, pass: $password, role: $role");
    final found = await _userRepository.findByNameAndPassword(username, password, role.id);
    debugAction("Login", "Found user : $found");
    if (found != null) {
      _saveSession(username);
      return found;
    }
    throw Exception("Username or password are wrong");
  }

  Future<void> logout() async {
    if (!await isLoggedIn()) {
      throw Exception("No user has been logged in");
    }
    await _clearSession();
    debugAction("Logout", "Logout success");
  }

  Future<List<Role>> getRoles() async {
    final roles = await _userRepository.getRoles();
    debugAction("Get roles", "Found roles : $roles");
    return roles;
  }
}
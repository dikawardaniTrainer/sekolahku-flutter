import 'package:sekolah_ku/model/user.dart';
import 'package:sekolah_ku/pref/user_pref.dart';
import 'package:sekolah_ku/repository/user_repository.dart';
import 'package:sekolah_ku/services/exception/exception.dart';
import 'package:sekolah_ku/util/logger.dart';

abstract class UserService {
  Future<bool> isLoggedIn();
  Future<User> login(String username, String password, Role role);
  Future<void> logout();
  Future<List<Role>> getRoles();
}

class UserServiceImpl extends UserService {
  final UserRepository _userRepository;
  final UserPref _userPref;

  UserServiceImpl(
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

  @override
  Future<bool> isLoggedIn() async {
    final savedToken = await _userPref.getToken();
    debugAction("Is logged in", "Saved token : $savedToken");
    final isLoggedIn = savedToken != null;
    debugAction("Is logged in", "Already logged in ? $isLoggedIn");
    return isLoggedIn;
  }

  @override
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

  @override
  Future<void> logout() async {
    if (!await isLoggedIn()) {
      throw Exception("No user has been logged in");
    }
    await _clearSession();
    debugAction("Logout", "Logout success");
  }

  @override
  Future<List<Role>> getRoles() async {
    final roles = await _userRepository.getRoles();
    debugAction("Get roles", "Found roles : $roles");
    if (roles.isNotEmpty) return roles;
    throw NotFoundException("No data roles has been found");
  }
}
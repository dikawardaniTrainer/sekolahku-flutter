import 'package:sekolah_ku/model/user.dart';
import 'package:sekolah_ku/services/user_service.dart';

abstract class LoginUseCase {
  Future<void> execute(String username, String password, Role role);
}

class LoginUseCaseImpl implements LoginUseCase {
  final UserService _service;

  LoginUseCaseImpl(this._service);

  @override
  Future<void> execute(String username, String password, Role role) async {
    await _service.login(username, password, role);
  }
}
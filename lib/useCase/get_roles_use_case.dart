import 'package:sekolah_ku/model/user.dart';
import 'package:sekolah_ku/services/user_service.dart';

abstract class GetRolesUseCase {
  Future<List<Role>> execute();
}

class GetRolesUseCaseImpl implements GetRolesUseCase {
  final UserService _userService;

  GetRolesUseCaseImpl(this._userService);

  @override
  Future<List<Role>> execute() => _userService.getRoles();
}
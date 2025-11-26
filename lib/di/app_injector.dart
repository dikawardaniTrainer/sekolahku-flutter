import 'package:sekolah_ku/database/database_open_helper.dart';
import 'package:sekolah_ku/pages/login/bloc/login_bloc.dart';
import 'package:sekolah_ku/pref/user_pref.dart';
import 'package:sekolah_ku/repository/student_repository.dart';
import 'package:sekolah_ku/repository/user_repository.dart';
import 'package:sekolah_ku/services/student_service.dart';
import 'package:sekolah_ku/services/user_service.dart';
import 'package:sekolah_ku/useCase/get_roles_use_case.dart';
import 'package:sekolah_ku/useCase/login_use_case.dart';

class AppInjector {
  static final DatabaseOpenHelper _openHelper = DatabaseOpenHelper();

  static UserRepository get _userRepository => UserDummyRepository();
  static StudentRepository get _studentRepository => StudentDbRepository(_openHelper);
  static UserPref get _userPref => UserPrefImpl();

  static StudentService get studentService => StudentServiceImpl(_studentRepository);
  static UserService get userService => UserServiceImpl(_userRepository, _userPref);

  static LoginUseCase get _loginUseCase => LoginUseCaseImpl(userService);
  static GetRolesUseCase get _getRolesUseCase => GetRolesUseCaseImpl(userService);

  static LoginBloc get loginBloc => LoginBloc(_loginUseCase, _getRolesUseCase);
}
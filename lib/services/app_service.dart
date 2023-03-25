import 'package:sekolah_ku/database/database_open_helper.dart';
import 'package:sekolah_ku/pref/user_pref.dart';
import 'package:sekolah_ku/repository/student_repository.dart';
import 'package:sekolah_ku/repository/user_repository.dart';
import 'package:sekolah_ku/services/student_service.dart';
import 'package:sekolah_ku/services/user_service.dart';

class AppService {
  static final DatabaseOpenHelper _openHelper = DatabaseOpenHelper();

  static final UserRepository _userRepository = UserDummyRepository();
  static final StudentRepository _studentRepository = StudentDbRepository(_openHelper);
  static final UserPref _userPref = UserPrefImpl();

  static StudentService get studentService => StudentServiceImpl(_studentRepository);
  static UserService get userService => UserService(_userRepository, _userPref);
}
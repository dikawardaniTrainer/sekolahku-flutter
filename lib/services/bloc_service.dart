import 'package:sekolah_ku/pages/login/bloc/login_bloc.dart';
import 'package:sekolah_ku/services/app_service.dart';

class BlocService {
  static final _userService = AppService.userService;

  static LoginBloc get loginBloc => LoginBloc(_userService);
}
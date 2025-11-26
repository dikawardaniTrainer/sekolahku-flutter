import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_ku/pages/login/bloc/login_event.dart';
import 'package:sekolah_ku/pages/login/bloc/login_state.dart';
import 'package:sekolah_ku/pages/login/bloc/login_status.dart';
import 'package:sekolah_ku/services/user_service.dart';
import 'package:sekolah_ku/util/logger.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserService _userService;

  LoginBloc(this._userService): super(LoginState()) {
    on<LoginEvent>((event, emit) async  {
      await _mapEventToState(event, emit);
    });
  }

  Future<void> _mapEventToState(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is UsernameChanged) {
      var newState = state.copyWith(username: event.username);
      emit(newState);
      debug("Username changed to ${newState.username}");
      return;
    }
    if (event is PasswordChanged) {
      var newState = state.copyWith(password: event.password);
      emit(newState);
      debug("Password changed to ${newState.password}");
      return;
    }
    if (event is RoleChanged) {
      var newState = state.copyWith(role: event.role);
      emit(newState);
      debug("Role changed to  ${newState.role}");
    }
    if (event is Submit) {
      _login(emit);
      return;
    }
    if (event is SetDefaultUser) {
      var newState = state.copyWith(username: event.username, password: event.password);
      emit(newState);
      return;
    }
  }

  Future<void> _login(Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(loginStatus: LoadingLogin()));
      await _userService.login(state.username, state.password, state.role);
      emit(state.copyWith(loginStatus: LoginSuccess()));
      debug("Submit login success");
    } on Exception catch(e) {
      emit(state.copyWith(loginStatus: LoginFailed(e)));
      debug("Submit login failed");
    }
  }
}
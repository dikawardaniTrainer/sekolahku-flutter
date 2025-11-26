import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_ku/constant/app_const.dart';
import 'package:sekolah_ku/pages/login/bloc/login_event.dart';
import 'package:sekolah_ku/pages/login/bloc/login_state.dart';
import 'package:sekolah_ku/pages/login/bloc/login_status.dart';
import 'package:sekolah_ku/useCase/get_roles_use_case.dart';
import 'package:sekolah_ku/useCase/login_use_case.dart';
import 'package:sekolah_ku/util/logger.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final GetRolesUseCase _getRolesUseCase;

  LoginBloc(this._loginUseCase, this._getRolesUseCase): super(LoginState()) {
    on<UsernameChanged>((event, emit) => _updateUsername(event, emit));
    on<PasswordChanged>((event, emit) => _updatePassword(event, emit));
    on<RoleChanged>((event, emit) => _updateRole(event, emit));
    on<LoadRoles>((event, emit) async => await _getRoles(emit));
    on<Submit>((event, emit) async => await _login(emit));
    on<SetDefaultUser>((event, emit) => _setDefaultUser(event, emit));
  }

  void _setDefaultUser(SetDefaultUser event, Emitter<LoginState> emit) {
    var newState = state.copyWith(username: event.username, password: event.password);
    emit(newState);
  }

  void _updateUsername(UsernameChanged event, Emitter<LoginState> emit) {
    var newState = state.copyWith(username: event.username, loginStatus: Initiate());
    emit(newState);
    debug("Username changed to ${newState.username}");
  }

  void _updatePassword(PasswordChanged event, Emitter<LoginState> emit) {
    var newState = state.copyWith(password: event.password, loginStatus: Initiate());
    emit(newState);
    debug("Password changed to ${newState.password}");
  }

  void _updateRole(RoleChanged event, Emitter<LoginState> emit) {
    var newState = state.copyWith(role: event.role, loginStatus: Initiate());
    emit(newState);
    debug("Role changed to  ${newState.role}");
  }

  Future<void> _login(Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(loginStatus: LoadingLogin()));
      if (useDummyLoading) await Future.delayed(const Duration(seconds: 5));
      await _loginUseCase.execute(state.username, state.password, state.role);
      emit(state.copyWith(loginStatus: LoginSuccess()));
      debug("Submit login success");
    } on Exception catch(e) {
      emit(state.copyWith(loginStatus: LoginFailed(e)));
      debug("Submit login failed");
    }
  }

  Future<void> _getRoles(Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(loginStatus: LoadingGetRoles()));
      if (useDummyLoading) await Future.delayed(const Duration(seconds: 5));
      final roles = await _getRolesUseCase.execute();
      emit(state.copyWith(roleOptions: roles, loginStatus: GetRolesSuccess()));
      debug("Get roles success");
    } on Exception catch(e) {
      emit(state.copyWith(loginStatus: GetRolesFailed(e)));
      debug("Get roles failed");
    }
  }
}
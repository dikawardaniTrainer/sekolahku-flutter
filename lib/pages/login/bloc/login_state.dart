import 'package:equatable/equatable.dart';
import 'package:sekolah_ku/model/user.dart';
import 'package:sekolah_ku/pages/login/bloc/login_status.dart';
import 'package:sekolah_ku/resources/string_res.dart';

 class LoginState extends Equatable {
  final String username, password;
  final Role role;
  final LoginStatus loginStatus;

  const LoginState({
    this.username = StringRes.emptyString,
    this.password = StringRes.emptyString,
    this.loginStatus = const Initiate(),
    this.role = const Role()
 });

  @override
  List<Object?> get props => [username, password, role, loginStatus];

  LoginState copyWith({
    String? username,
    String? password,
    Role? role,
    LoginStatus? loginStatus
  }) => LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      loginStatus: loginStatus ?? this.loginStatus
  );

 }
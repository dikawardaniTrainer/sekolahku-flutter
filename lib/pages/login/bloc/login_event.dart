import 'package:equatable/equatable.dart';
import 'package:sekolah_ku/model/user.dart';

abstract class LoginEvent extends Equatable {}

class UsernameChanged extends LoginEvent {
  final String? username;

  UsernameChanged({this.username});

  @override
  List<Object?> get props => [username];
}

class PasswordChanged extends LoginEvent {
  final String? password;

  PasswordChanged({this.password});

  @override
  List<Object?> get props => [password];
}

class RoleChanged extends LoginEvent {
  final Role? role;

  RoleChanged({this.role});

  @override
  List<Object?> get props => [role];
}

class Submit extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class SetDefaultUser extends LoginEvent {
  final String username;
  final String? password;

  SetDefaultUser(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

class LoadRoles extends LoginEvent {
  @override
  List<Object?> get props => [];

}
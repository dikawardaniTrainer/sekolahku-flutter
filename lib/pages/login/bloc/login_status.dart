abstract class LoginStatus {
  const LoginStatus();
}

class Initiate extends LoginStatus {
  const Initiate();
}

class LoadingLogin extends LoginStatus {}
class LoginSuccess extends LoginStatus {}
class LoginFailed extends LoginStatus {
  final Exception err;
  LoginFailed(this.err);
}

class LoadingGetRoles extends LoginStatus {}
class GetRolesSuccess extends LoginStatus {}
class GetRolesFailed extends LoginStatus {
  final Exception err;
  GetRolesFailed(this.err);
}
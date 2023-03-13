import 'package:sekolah_ku/resources/string_res.dart';

class User {
  String username, password, fullName;
  Role role;

  User({
    this.username = StringRes.emptyString,
    this.password = StringRes.emptyString,
    this.fullName = StringRes.emptyString,
    required this.role
  });

  @override
  String toString() {
    return "username : $username, password: $password";
  }
}

class Role {
  int id;
  String name;

  Role({
    this.id = 0,
    this.name = StringRes.emptyString
  });

  @override
  String toString() {
    return "id: $id, role: $name";
  }

  @override
  bool operator == (dynamic other) =>
      other != null && other is Role && id == other.id && name == other.name;

  @override
  int get hashCode => Object.hash(id, name);

}
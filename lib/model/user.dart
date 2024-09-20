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
    return { "username" : username, "password": password, "role": role }.toString();
  }

  @override
  bool operator == (Object other) =>
      other is User && other.toString() == toString();

  @override
  int get hashCode => Object.hash(username, password, role);
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
    return {"id": id, "name": name}.toString();
  }

  @override
  bool operator == (Object other) =>
      other is Role && other.toString() == toString();

  @override
  int get hashCode => Object.hash(id, name);

}
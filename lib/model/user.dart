import 'package:equatable/equatable.dart';
import 'package:sekolah_ku/resources/string_res.dart';

class User extends Equatable {
  String username, password, fullName;
  Role role;

  User({
    this.username = StringRes.emptyString,
    this.password = StringRes.emptyString,
    this.fullName = StringRes.emptyString,
    required this.role
  });

  @override
  List<Object?> get props => [username, password, role];
}

class Role {
  final int id;
  final String name;

  const Role({
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
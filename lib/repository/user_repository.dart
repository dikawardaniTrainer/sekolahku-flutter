import 'package:sekolah_ku/model/user.dart';

abstract class UserRepository {
  Future<User?> findByNameAndPassword(
      String username,
      String password,
      int roleId
  );

  Future<List<Role>> getRoles();
}

class UserDummyRepository implements UserRepository {
  final _users = [
    User(
      username: "admin@rc.com",
      password: "admin1",
      fullName: "Admin Sekolah Ku",
      role: Role(
        id: 1,
        name: "Admin"
      )
    )
  ];

  @override
  Future<User?> findByNameAndPassword(
      String username,
      String password,
      int roleId
  ) {
    return Future(() {
      try {
        return _users.firstWhere((savedData) => savedData.password == password && savedData.username == username && savedData.role.id == roleId
        );
      } catch(e) {
        return null;
      }
    });
  }

  @override
  Future<List<Role>> getRoles() {
    return Future(() => [
      Role(id: 1, name: "Admin"),
      Role(id: 2, name: "Supervisor"),
      Role(id: 3, name: "Manager")
    ]);
  }
}
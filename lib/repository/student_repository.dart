import 'package:sekolah_ku/database/database_open_helper.dart';
import 'package:sekolah_ku/database/student_table.dart';
import 'package:sqflite/sqflite.dart';

abstract class StudentRepository {
  Future<List<Map<String, Object?>>> findAll();
  Future<Map<String, Object?>?> findById(int id);
  Future<void> save(Map<String, Object?> data);
  Future<void> delete(int id);
  Future<List<Map<String, Object?>>> findByName(String name);
  Future<void> update(Map<String, Object?> newData, int id);
  Future<int> countByEmail(String email);
  Future<int> countTotal();
}

class StudentDbRepository implements StudentRepository {
  final DatabaseOpenHelper _openHelper;

  StudentDbRepository(this._openHelper);

  @override
  Future<int> countByEmail(String email) async {
    final db = await _openHelper.getDatabase();
    const query = 'SELECT COUNT (*) FROM ${StudentTable.tableName} WHERE ${StudentTable.emailField}=?';
    var result = await db.rawQuery(query, [email]);
    int? count = Sqflite.firstIntValue(result);
    if (count != null) return count;
    return 0;
  }

  @override
  Future<int> countTotal() async {
    final db = await _openHelper.getDatabase();
    const query = 'SELECT COUNT (*) FROM ${StudentTable.tableName}';
    var result = await db.rawQuery(query, []);
    int? count = Sqflite.firstIntValue(result);
    if (count != null) return count;
    return 0;
  }

  @override
  Future<List<Map<String, Object?>>> findAll() async {
    final db = await _openHelper.getDatabase();
    final result = await db.query(StudentTable.tableName);
    await db.close();
    return result;
  }

  @override
  Future<Map<String, Object?>?> findById(int id) async {
    final db = await _openHelper.getDatabase();
    final result = await db.query(
        StudentTable.tableName,
        where: "${StudentTable.idField}=?",
        whereArgs: [id]
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  @override
  Future<List<Map<String, Object?>>> findByName(String name) async {
    final db = await _openHelper.getDatabase();
    const query = "SELECT * FROM ${StudentTable.tableName} WHERE ${StudentTable.firstNameField} LIKE ? OR ${StudentTable.lastNameField} LIKE ?";
    final result = await db.rawQuery(query,["%$name%", "%$name%"]);
    await db.close();
    return result;
  }

  @override
  Future<void> delete(int id) async {
    final db = await _openHelper.getDatabase();

    await db.delete(
        StudentTable.tableName,
        where: "${StudentTable.idField} = ?",
        whereArgs: [id]
    );
    await db.close();
  }

  @override
  Future<void> save(Map<String, Object?> data) async {
    final db = await _openHelper.getDatabase();

    await db.insert(
        StudentTable.tableName,
        data,
        conflictAlgorithm: ConflictAlgorithm.fail
    );
    await db.close();
  }

  @override
  Future<void> update(Map<String, Object?> newData, int id) async {
    final db = await _openHelper.getDatabase();

    await db.update(
        StudentTable.tableName,
        newData,
        where: "${StudentTable.idField} = ?",
        whereArgs: [id]
    );
    await db.close();
  }
}
import 'package:path/path.dart';
import 'package:sekolah_ku/database/student_table.dart';
import 'package:sekolah_ku/util/logger.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseOpenHelper {

  Future<Database> getDatabase() async {
    final databasePath = await getDatabasesPath();
    return openDatabase(
      join(databasePath, "sekolahku.db"),
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDownGrade
    );
  }

  OnDatabaseCreateFn get _onCreate => (db, version) {
    const queryCreateTableStudent = """ 
      CREATE TABLE ${StudentTable.tableName} (
        ${StudentTable.idField} INTEGER PRIMARY KEY AUTOINCREMENT, 
        ${StudentTable.firstNameField} TEXT,
        ${StudentTable.lastNameField} TEXT,
        ${StudentTable.phoneField} TEXT,
        ${StudentTable.emailField} TEXT,
        ${StudentTable.birthDateField} TEXT,
        ${StudentTable.educationField} TEXT,
        ${StudentTable.genderField} TEXT,
        ${StudentTable.hobbiesField} TEXT,
        ${StudentTable.addressField} TEXT
      )
      """;

    db.execute(queryCreateTableStudent);
  };

  OnDatabaseVersionChangeFn get _onUpgrade => (db, oldVersion, newVersion) {
    if (newVersion > oldVersion) {
      if (newVersion == 2) {
        const queryAddColumnAddress = "ALTER TABLE ${StudentTable.tableName} ADD ${StudentTable.addressField} TEXT";
        db.execute(queryAddColumnAddress);
      }
    }
  };

  OnDatabaseVersionChangeFn get _onDownGrade => (db, oldVersion, newVersion) {
    debug("old : $oldVersion, new: $newVersion");
    if (oldVersion > newVersion) {
      if (oldVersion == 2) {
        const queryRemoveColumnAddress = "ALTER TABLE ${StudentTable.tableName} DROP COLUMN ${StudentTable.addressField}";
        db.execute(queryRemoveColumnAddress);
      }
    }
  };
}
import 'package:sekolah_ku/model/student.dart';
import 'package:sekolah_ku/services/mapper/student_mapper.dart';
import 'package:sekolah_ku/repository/student_repository.dart';
import 'package:sekolah_ku/services/exception/exception.dart';
import 'package:sekolah_ku/util/logger.dart';

abstract class StudentService {
  Future<List<Student>> findAll();
  Future<Student> findById(int id);
  Future<void> save(Student student);
  Future<void> delete(Student student);
  Future<List<Student>> findByName(String name);
  Future<void> update(Student student);
}

class StudentServiceImpl implements StudentService {

  final StudentRepository _studentRepository;

  StudentServiceImpl(this._studentRepository);

  @override
  Future<List<Student>> findAll() async {
    final results = await _studentRepository.findAll();
    debugAction("Find All", "Total data found : ${results.length}\nData on db :\n$results");
    if (results.isNotEmpty) {
      return results.map((e) => e.toStudent())
          .toList();
    }
    throw NotFoundException("No data students has been saved in database");
  }

  @override
  Future<Student> findById(int id) async {
    final found = await _studentRepository.findById(id);
    debugAction("Find By ID", "Id to find : $id\nFound data on db :\n$found");
    if (found != null) return found.toStudent();
    throw NotFoundException("Student with id : $id not exist");
  }

  @override
  Future<void> save(Student student) async {
    final isEmailExist = await _studentRepository.countByEmail(student.email) > 0;
    debugAction("Save", "Is email exist : $isEmailExist");
    if (isEmailExist) {
      throw DuplicateEmailException("Email already exist");
    }
    await _studentRepository.save(student.toMap());
    debugAction("Save", "Saved on db");
  }

  @override
  Future<void> delete(Student student) async {
    final found = await _studentRepository.findById(student.id);
    debugAction("Delete", "Data to delete: $student\nData on db: $found");
    if (found != null) {
      final foundData = found.toStudent();
      await _studentRepository.delete(foundData.id);
      debugAction("Delete", "Data deleted");
      return;
    }
    throw NotFoundException("Student with id ${student.id} no longer exist");
  }

  @override
  Future<List<Student>> findByName(String name) async {
    final founds = await _studentRepository.findByName(name);
    debugAction("Find by name", "Key name to search : $name\nTotal data founds: ${founds.length}\nData on db: $founds");
    if (founds.isEmpty) throw NotFoundException("No data students that contain $name");
    return founds.map((e) => e.toStudent())
        .toList();
  }

  @override
  Future<void> update(Student student) async {
    final found = await _studentRepository.findById(student.id);
    debugAction("Update", "Data to delete : $student\nData on db : $found");
    if (found != null) {
      final oldData = found.toStudent();
      final isOldSameWithNew = oldData == student;
      debugAction("Update", "Is db data and new data are the same : $isOldSameWithNew");
      if (isOldSameWithNew) throw NoDataChangedException("New data student is equal to the old one that saved in database");
      await _studentRepository.update(student.toMap(), student.id);
      debugAction("Update", "Data updated");
      return;
    }
    throw NotFoundException("Student with id ${student.id} no longer exist");
  }
}
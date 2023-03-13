import 'package:sekolah_ku/database/student_table.dart';
import 'package:sekolah_ku/model/student.dart';
import 'package:sekolah_ku/util/common_extension.dart';
import 'package:sekolah_ku/util/date_extension.dart';

extension StudentToMap on Student {
  Map<String, Object?> toMap() {
    String? hobbiesToSave;

    if (hobbies.isNotEmpty) {
      hobbiesToSave = hobbies.join(", ");
    }

    return {
      StudentTable.firstNameField : firstname,
      StudentTable.lastNameField : lastname,
      StudentTable.phoneField : phoneNumber,
      StudentTable.emailField : email,
      StudentTable.birthDateField : birthDate.format(),
      StudentTable.educationField : education,
      StudentTable.genderField : gender,
      StudentTable.hobbiesField : hobbiesToSave,
      StudentTable.addressField: address
    };
  }
}

extension MapToModel  on Map<String, Object?> {
  Student toStudent() {
    return Student(
      id: this[StudentTable.idField].toInt(),
      firstname: this[StudentTable.firstNameField].toStringOrEmpty(),
      lastname: this[StudentTable.lastNameField].toStringOrEmpty(),
      phoneNumber: this[StudentTable.phoneField].toStringOrEmpty(),
      email: this[StudentTable.emailField].toStringOrEmpty(),
      birthDate: this[StudentTable.birthDateField].toDateWhenString(),
      gender: this[StudentTable.genderField].toStringOrEmpty(),
      hobbies: this[StudentTable.hobbiesField].toListWhenString(),
      education: this[StudentTable.educationField].toStringOrEmpty(),
      address: this[StudentTable.addressField].toStringOrEmpty()
    );
  }
}
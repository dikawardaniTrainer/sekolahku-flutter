import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/util/date_extension.dart';

class Student {
  var id = -1;
  String firstname, lastname, phoneNumber, email, education, gender, address, gmapsLink;
  DateTime? birthDate;
  List<String> hobbies = [];
  String get fullName => "$firstname $lastname";

  Student({
    this.id = -1,
    this.firstname = StringRes.emptyString,
    this.lastname = StringRes.emptyString,
    this.phoneNumber = StringRes.emptyString,
    this.email = StringRes.emptyString,
    this.education = StringRes.emptyString,
    this.gender = StringRes.emptyString,
    this.address = StringRes.emptyString,
    this.birthDate,
    this.hobbies = const [],
    this.gmapsLink = StringRes.emptyString
  });

  @override
  String toString() {
    return {
      "Id": id,
      "first_name": firstname,
      "last_name": lastname,
      "phone_number": phoneNumber,
      "email": email,
      "birthdate": birthDate.format(),
      "education": education,
      "gender": gender,
      "hobbies": hobbies.join(", "),
      "address": address
    }.toString();
  }

  @override
  bool operator == (Object other) =>
      other is Student && other.toString() == toString();

  @override
  int get hashCode => Object.hash(id, firstname, lastname, phoneNumber, email, education, gender, address, gmapsLink, birthDate, hobbies);
}

import 'package:sprintf/sprintf.dart';

class StringRes {
  static const noValue = "-";
  static const emptyString = "";
  static const appName = "Sekolah Ku";
  static const username = "Username";
  static const password = "Password";
  static const login = "Login";
  static const logout = "Logout";
  static const detailStudent = "Detail Student";
  static const editDataStudent = "Edit Data Student";
  static const addNewStudent = "Add New Student";
  static const firstName = "First Name";
  static const lastName = "Last Name";
  static const phoneNumber = "Phone Number";
  static const email = "Email";
  static const birthDate = "Birth Date";
  static const education = "Education";
  static const gender = "Gender";
  static const hobbies = "Hobbies";
  static const address = "Address";
  static const save = "Save";
  static const notFound = "Not Found";
  static const fullName = "Fullname";
  static const notRecorded = "<Not recorded yet>";
  static const edit = "Edit";
  static const delete = "Delete";
  static const male = "Male";
  static const female = "Female";
  static const both = "Both";
  static const deleteStudent = "Delete Student";
  static const ok = "Okay";
  static const cancel = "Cancel";
  static const update = "Update";
  static const role = "Role";
  static const retry = "Retry";
  static const info = "info";
  static const filter = "Filter";
  static const apply = "Apply";
  static const resetFilter = "Reset Filter";
  static const pleaseSelectEducation = "*** Please select one education ***";
  static const sd = "SD";
  static const smp = "SMP";
  static const sma = "SMA";
  static const s1 = "S1";
  static const reading = "Reading";
  static const writing = "Writing";
  static const drawing = "drawing";
  static const success = "Success";
  static const failed = "Failed";
  static const goBack = "Go Back";
  static const goBackHome = "Back to Home";
  static const filterApplied = "Filter Applied";

  static const loadingStudents = "Loading students data";
  static const loadingDetailStudent = "Loading detail student";
  static const loadingContents = "Loading contents";
  static const loadingLogin = "Please wait while Logging in";
  static const loadingSaveStudent = "Please wait while saving new data student";
  static const loadingUpdateStudent = "Please wait while updating data student";
  static const loadingLogout = "Please wait while logging out";

  static const errEmailEmpty = "Email cannot be empty";
  static const errEmailInvalid = "Invalid email address";
  static const errPasswordEmpty = "Password cannot be empty";
  static const errPasswordInvalid = "Password must be 6 character or more";
  static const errSomeInputInvalid = "Your input is still not valid, please fix it first before continue";
  static const _errorStudentIdNotFound = "Data student with id : %s is not found";
  static const errFieldEmpty = "%s cannot be empty";
  static const errSpecialCharacter = "Special character rejected";
  static const errPhoneNumberEmpty = "Phone number cannot be empty";
  static const errPhoneNumberInvalid = "Phone number is invalid";
  static const errAddressEmpty = "Address cannot be empty";
  static const errBirthDateEmpty = "Birth date cannot be empty";
  static const errBirthDateInvalid = "Birth date is invalid";
  static const errBirthDateBeforeMin = "Birth date before %s is not acceptable";
  static const errBirthDateAfterMax = "Birth date after %s is not acceptable";
  static const errEducationEmpty = "No education has been selected";
  static const errNoDataStudents = "No data students has been found";
  static const errOpenMapsNotSupported = "Uppss, opening maps link is not currently supported on platform, please try again later";
  static const errSaveNewStudent = "Failed to save data student, please try again later";
  static const errUpdateStudent = "Failed to update data student, please try again later";
  static const errUpdateNoDataChanged = "No data has been changed, update data is cancelled";
  static const errEmailExisted = "The email that you use is already exist, please use another one";
  static const errFetchRoles = "Unable to fetch roles";
  static const errRoleRequired = "Please select the role first";
  static const errFilterStudents = "To filter student data, please provide the gender or education or both";
  static const _errFilterNotFoundsForFull = "No data students has been found with gender %s and education %s";
  static const _errFilterNotFoundsForGender = "No data students has been found with gender %s";
  static const _errFilterNotFoundsForEducation = "No data students has been found with education %s";

  static const successSaveStudent = "Data student saved successfully";
  static const successUpdateStudent = "Data student updated successfully";
  static const successDeleteStudent = "Data student has been deleted successfully";

  static const confirmLogout = "Are you sure want to logout ?";
  static const _confirmDeleteStudent = "Are you sure want to delete %s ?";

  static String messageErrorStudentIdNotFound(int id) => sprintf(_errorStudentIdNotFound, [id]);

  static String messageErrorFilterStudents(String? gender, String? education) {
    if (gender != null && education != null) return sprintf(_errFilterNotFoundsForFull, [gender, education]);
    if (gender != null) return sprintf(_errFilterNotFoundsForGender, [gender]);
    return sprintf(_errFilterNotFoundsForEducation, [education]);
  }

  static String messageConfirmDeleteStudent(String fullName) => sprintf(_confirmDeleteStudent, [fullName]);

}
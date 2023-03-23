import 'package:flutter/material.dart';
import 'package:sekolah_ku/model/student.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/services/app_service.dart';
import 'package:sekolah_ku/constant/student_const.dart';
import 'package:sekolah_ku/services/exception/exception.dart';
import 'package:sekolah_ku/util/common_extension.dart';
import 'package:sekolah_ku/util/date_extension.dart';
import 'package:sekolah_ku/util/navigation_extension.dart';
import 'package:sekolah_ku/constant/validation_const.dart';
import 'package:sekolah_ku/util/logger.dart';
import 'package:sekolah_ku/util/widget_extension.dart';
import 'package:sekolah_ku/widgets/button.dart';
import 'package:sekolah_ku/widgets/checkbox_group.dart';
import 'package:sekolah_ku/widgets/dropdown.dart';
import 'package:sekolah_ku/widgets/icon_back_button.dart';
import 'package:sekolah_ku/widgets/input.dart';
import 'package:sekolah_ku/widgets/radio_group.dart';
import 'package:sprintf/sprintf.dart';

class StudentFormPage extends StatefulWidget {
  final int studentIdToEdit;

  const StudentFormPage({
    super.key,
    this.studentIdToEdit = -1
  });

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final _studentService = AppService.studentService;
  final _formKey = GlobalKey<FormState>();

  final _birthDateCtrl = TextEditingController();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _phoneNumberCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _genderCtrl = TextEditingController();
  final _selectedEducation = DropDownController<String>(educationOptions[0]);
  
  List<String> selectedHobbies = [];

  bool get _isEditMode => widget.studentIdToEdit != -1;

  String get _pageTitle {
    if (_isEditMode) return StringRes.editDataStudent;
    return StringRes.addNewStudent;
  }

  String get _buttonTitle {
    if (_isEditMode) return StringRes.update;
    return StringRes.save;
  }

  _isContainSpecialCharacter(String input) {
    var contained = false;
    for(int i=0; i<forbiddenCharacters.length; i++) {
      if (input.contains(forbiddenCharacters[i])) {
        contained = true;
        break;
      }
    }

    return contained;
  }

  String? _validateName(String? input, String fieldName) {
    if (input != null) {
      if (input.isEmpty) {
        return sprintf(StringRes.errFieldEmpty, [fieldName]);
      }

      var regexValid = regexName.hasMatch(input);
      if (!regexValid | _isContainSpecialCharacter(input)) {
        return StringRes.errSpecialCharacter;
      }
    }

    return null;
  }

  String? _validateEmail(String? input) {
    if (input != null) {
      if (input.isEmpty) {
        return StringRes.errEmailEmpty;
      }
      final bool emailValid = regexEmail.hasMatch(input);
      if (!emailValid) {
        return StringRes.errEmailInvalid;
      }
    }
    return null;
  }

  String? _validatePhoneNumber(String? input) {
    if (input != null) {
      if (input.isEmpty) {
        return StringRes.errPhoneNumberEmpty;
      }
      final bool isValid = regexPhoneNumber.hasMatch(input);
      if (!isValid) {
        return StringRes.errPhoneNumberInvalid;
      }
    }
    return null;
  }

  String? _validateAddress(String? input) {
    if (input != null) {
      if (input.isEmpty) {
        return StringRes.errAddressEmpty;
      }
    }
    return null;
  }

  String? _validateBirthDate(String? input) {
    if (input != null) {
      if (input.isEmpty) {
        return StringRes.errBirthDateEmpty;
      }

      final dateTime = input.parse();
      if (dateTime != null) {
        if (dateTime.isBefore(minimumBirthDate)) {
          return sprintf(StringRes.errBirthDateBeforeMin, [minimumBirthDate.format()]);
        }
        if (dateTime.isAfter(maxBirthDate)) {
          return sprintf(StringRes.errBirthDateAfterMax, [maxBirthDate.format()]);
        }
      } else {
        return StringRes.errBirthDateInvalid;
      }
    }

    return null;
  }

  String? _validateEducation(String? input) {
    if (input != null) {
      if (input == educationOptions.first) {
        return StringRes.errEducationEmpty;
      }
    }
    return null;
  }

  Student _collectInput() {
    return Student(
      firstname: _firstNameCtrl.text,
      lastname: _lastNameCtrl.text,
      phoneNumber: _phoneNumberCtrl.text,
      email: _emailCtrl.text,
      birthDate: _birthDateCtrl.text.parse(),
      education: _selectedEducation.value.toStringOrEmpty(),
      gender: _genderCtrl.text,
      hobbies: selectedHobbies,
      address: _addressCtrl.text
    );
  }

  void _saveNewData() {
    var student = _collectInput();
    _studentService.save(student)
        .then((value) {
          context.showSuccessSnackBar(StringRes.successSaveStudent);
          context.goBack();
        }).catchError((e, s) {
          var errorMessage = StringRes.errSaveNewStudent;
          if (e is DuplicateEmailException) {
            errorMessage = StringRes.errEmailExisted;
          }
          context.showErrorSnackBar(errorMessage);
          debugError(e, s);
        });
  }

  void _updateData(int id) {
    var student = _collectInput();
    student.id = id;
    _studentService.update(student)
        .then((value) {
          context.showSuccessSnackBar(StringRes.successUpdateStudent);
          context.goBack();
        }).catchError((e, s) {
          String message;
          if (e is NoDataChangedException) {
            message = StringRes.errUpdateNoDataChanged;
          } else {
            message = StringRes.errUpdateStudent;
          }

          context.showErrorSnackBar(message);
          debugError(e, s);
        });
  }

  void _save() {
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      if (_isEditMode) {
        _updateData(widget.studentIdToEdit);
      } else {
        _saveNewData();
      }
    } else {
      context.showErrorSnackBar(StringRes.errSomeInputInvalid);
    }
  }

  void _showDatePickerDialog() {
    var initialDate = DateTime.now();
    
    if (_birthDateCtrl.text.isNotEmpty) {
      final date = _birthDateCtrl.text.parse();
      if (date != null) {
        initialDate = date;
      }
    }
    
    showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1989),
      lastDate: DateTime(2024)
    ).then((value) {
      if (value != null) {
        _birthDateCtrl.value = TextEditingValue(text: value.format());
      }
    });
  }

  void _showOldStudentData(Student oldStudent) {
    setState(() {
      _birthDateCtrl.text = oldStudent.birthDate.format();
      _firstNameCtrl.text = oldStudent.firstname;
      _lastNameCtrl.text = oldStudent.lastname;
      _phoneNumberCtrl.text = oldStudent.phoneNumber;
      _emailCtrl.text = oldStudent.email;
      _addressCtrl.text = oldStudent.address;

      _genderCtrl.text = oldStudent.gender;
      _selectedEducation.value = oldStudent.education;
      selectedHobbies = oldStudent.hobbies;
    });
  }

  void findStudentToEdit(int id) {
    _studentService.findById(id)
        .then((value) => _showOldStudentData(value))
        .catchError((e, s) {
          context.showErrorSnackBar(
            sprintf(StringRes.errorStudentIdNotFound, [id])
          );
          debugError(e, s);
        });
  }

  @override
  void initState() {
    super.initState();
    final id = widget.studentIdToEdit;
    if (_isEditMode) {
      findStudentToEdit(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    const gap = DimenRes.size_16;

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle),
        leading: const IconBackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(gap),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: InputField(
                      label: StringRes.firstName,
                      textInputType: TextInputType.text,
                      controller: _firstNameCtrl,
                      validator: (s) {
                        return _validateName(s, StringRes.firstName);
                      },
                    )),
                    const SizedBox(width: 8,),
                    Expanded(child: InputField(
                      label: StringRes.lastName,
                      textInputType: TextInputType.text,
                      controller: _lastNameCtrl,
                      validator: (s) {
                        return _validateName(s, StringRes.lastName);
                      },
                    ))
                  ],
                ),
                InputField(
                  label: StringRes.phoneNumber,
                  textInputType: TextInputType.phone,
                  validator: (s) { return _validatePhoneNumber(s); },
                  controller: _phoneNumberCtrl,
                  marginTop: gap,
                ),
                InputField(
                  label: StringRes.email,
                  textInputType: TextInputType.emailAddress,
                  validator: (s) { return _validateEmail(s); },
                  controller: _emailCtrl,
                  marginTop: gap,
                ),
                InputField(
                  label: StringRes.birthDate,
                  controller: _birthDateCtrl,
                  readOnly: true,
                  textInputType: TextInputType.none,
                  validator: (s) { return _validateBirthDate(s); },
                  marginTop: gap,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.date_range , color: Theme.of(context).primaryColor),
                    onPressed: () { _showDatePickerDialog(); },
                  ),
                ),
                DropDown<String>(
                  label: StringRes.education,
                  controller: _selectedEducation,
                  options: educationOptions,
                  onDrawItem: (item) => Text(item),
                  marginTop: gap,
                  onChanged: (s) { _selectedEducation.value = s; },
                  validator: (s) { return _validateEducation(s); },
                ),
                RadioGroup(
                  label: StringRes.gender,
                  controller: _genderCtrl,
                  options: genderOptions,
                  onChanged: (s) { _genderCtrl.text = s; },
                  marginTop: gap,
                ),
                CheckBoxGroup(
                  label: StringRes.hobbies,
                  marginTop: gap,
                  selectedOptions: selectedHobbies,
                  options: hobiesOptions,
                  onChanged: (selectedOptions) {
                    selectedHobbies = selectedOptions;
                  },
                ),
                InputField(
                  label: StringRes.address,
                  maxLine: 3,
                  controller: _addressCtrl,
                  textInputType: TextInputType.multiline,
                  validator: (s) { return _validateAddress(s); },
                  marginTop: gap,
                ),
                Button(
                  label: _buttonTitle,
                  onPressed: () { _save(); },
                  marginTop: gap,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
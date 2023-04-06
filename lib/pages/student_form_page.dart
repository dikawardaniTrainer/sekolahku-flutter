import 'package:flutter/material.dart';
import 'package:sekolah_ku/model/student.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/services/app_service.dart';
import 'package:sekolah_ku/constant/student_const.dart';
import 'package:sekolah_ku/services/exception/exception.dart';
import 'package:sekolah_ku/util/common_extension.dart';
import 'package:sekolah_ku/util/date_extension.dart';
import 'package:sekolah_ku/util/form_ext.dart';
import 'package:sekolah_ku/util/navigation_extension.dart';
import 'package:sekolah_ku/util/snackbar_extension.dart';
import 'package:sekolah_ku/util/state_extension.dart';
import 'package:sekolah_ku/util/dialog_extension.dart';
import 'package:sekolah_ku/widgets/button.dart';
import 'package:sekolah_ku/widgets/checkbox_group.dart';
import 'package:sekolah_ku/widgets/custom_future_builder.dart';
import 'package:sekolah_ku/widgets/dropdown.dart';
import 'package:sekolah_ku/widgets/icon_back_button.dart';
import 'package:sekolah_ku/widgets/input_date_field.dart';
import 'package:sekolah_ku/widgets/input_education.dart';
import 'package:sekolah_ku/widgets/input_email.dart';
import 'package:sekolah_ku/widgets/input_name.dart';
import 'package:sekolah_ku/widgets/input_phone_number.dart';
import 'package:sekolah_ku/widgets/input_required_field.dart';
import 'package:sekolah_ku/widgets/loading_dialog.dart';
import 'package:sekolah_ku/widgets/radio_gender.dart';
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
  final _educationCtrl = DropDownController<String>(educationOptions[0]);
  final _hobbiesCtrl = CheckBoxController(hobbiesOptions, []);

  bool get _isEditMode => widget.studentIdToEdit != -1;
  var _isOldDataLoaded = false;
  var _isButtonAlreadyHitOnce = false;

  bool get _isButtonEnabled {
    return _formKey.isAllInputValid || !_isButtonAlreadyHitOnce;
  }

  String get _pageTitle {
    if (_isEditMode) return StringRes.editDataStudent;
    return StringRes.addNewStudent;
  }

  String get _buttonTitle {
    if (_isEditMode) return StringRes.update;
    return StringRes.save;
  }

  Student _collectInput() {
    return Student(
      firstname: _firstNameCtrl.text,
      lastname: _lastNameCtrl.text,
      phoneNumber: _phoneNumberCtrl.text,
      email: _emailCtrl.text,
      birthDate: _birthDateCtrl.text.parse(),
      education: _educationCtrl.value.toStringOrEmpty(),
      gender: _genderCtrl.text,
      hobbies: _hobbiesCtrl.value,
      address: _addressCtrl.text
    );
  }

  void _saveNewData() {
    var student = _collectInput();
    context.showLoadingDialog(
        message: StringRes.loadingSaveStudent,
        future: _studentService.save(student),
        onGetResult: (data) {
          context.showSuccessSnackBar(StringRes.successSaveStudent);
          context.goBack();
        },
        onGetError: (e, s) {
          var errorMessage = StringRes.errSaveNewStudent;
          if (e is DuplicateEmailException) {
            errorMessage = StringRes.errEmailExisted;
          }
          context.showErrorSnackBar(errorMessage);
        }
    );
  }

  void _updateData(int id) {
    var student = _collectInput();
    student.id = id;
    context.showLoadingDialog(
        message: StringRes.loadingUpdateStudent,
        future: _studentService.update(student),
        onGetResult: (data) {
          context.showSuccessSnackBar(StringRes.successUpdateStudent);
          context.goBack();
        },
        onGetError: (e, s) {
          String message;
          if (e is NoDataChangedException) {
            message = StringRes.errUpdateNoDataChanged;
          } else {
            message = StringRes.errUpdateStudent;
          }
          context.showErrorSnackBar(message);
        }
    );
  }

  void _save() {
    _isButtonAlreadyHitOnce = true;
    if (_formKey.isAllInputValid) {
      if (_isEditMode) {
        _updateData(widget.studentIdToEdit);
      } else {
        _saveNewData();
      }
    } else {
      context.showErrorSnackBar(StringRes.errSomeInputInvalid);
      _toggleButton();
    }
  }

  void _setOldStudentData(Student oldStudent) {
    _birthDateCtrl.text = oldStudent.birthDate.format();
    _firstNameCtrl.text = oldStudent.firstname;
    _lastNameCtrl.text = oldStudent.lastname;
    _phoneNumberCtrl.text = oldStudent.phoneNumber;
    _emailCtrl.text = oldStudent.email;
    _addressCtrl.text = oldStudent.address;

    _genderCtrl.text = oldStudent.gender;
    _educationCtrl.value = oldStudent.education;
    _hobbiesCtrl.value = oldStudent.hobbies;
    _isOldDataLoaded = true;
    _isButtonAlreadyHitOnce = true;
  }

  void _toggleButton() {
    if (_isButtonAlreadyHitOnce) refresh();
  }

  Widget _createForm() {
    const gap = DimenRes.size_16;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(gap),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: InputNameField(
                    label: StringRes.firstName,
                    controller: _firstNameCtrl,
                    onChanged: (v) => _toggleButton(),
                  )),
                  const SizedBox(width: 8,),
                  Expanded(child: InputNameField(
                    label: StringRes.lastName,
                    controller: _lastNameCtrl,
                    onChanged: (v) => _toggleButton(),
                  ))
                ],
              ),
              InputPhoneNumberField(
                controller: _phoneNumberCtrl,
                marginTop: gap,
                onChanged: (v) => _toggleButton()
              ),
              InputEmailField(
                label: StringRes.email,
                controller: _emailCtrl,
                marginTop: gap,
                onChanged: (v) => _toggleButton(),
              ),
              InputDateField(
                label: StringRes.birthDate,
                controller: _birthDateCtrl,
                marginTop: gap,
                minDate: minimumBirthDate,
                maxDate: maxBirthDate,
                minDatePicker: DateTime(1989),
                maxDatePicker: DateTime(2024),
                onChanged: (v) => _toggleButton(),
                onShowError: (cause) {
                  switch (cause) {
                    case ErrorType.required: return StringRes.errBirthDateEmpty;
                    case ErrorType.minDateReached: return sprintf(StringRes.errBirthDateBeforeMin, [minimumBirthDate.format()]);
                    case ErrorType.maxDateReached: return sprintf(StringRes.errBirthDateAfterMax, [maxBirthDate.format()]);
                    case ErrorType.invalid: return StringRes.errBirthDateInvalid;
                  }
                },
              ),
              InputEducation(
                controller: _educationCtrl,
                marginTop: gap,
              ),
              RadioGender(
                controller: _genderCtrl,
                marginTop: gap,
              ),
              CheckBoxGroup(
                label: StringRes.hobbies,
                marginTop: gap,
                controller: _hobbiesCtrl,
              ),
              InputRequiredField(
                label: StringRes.address,
                marginTop: gap,
                minLine: 3,
                controller: _addressCtrl,
                textInputType: TextInputType.multiline,
                onGetErrorMessage: () => StringRes.errAddressEmpty,
                onChanged: (s) => _toggleButton(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _createPage() {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pageTitle),
          leading: const IconBackButton(),
          actions: [
            IconButton(
              icon: const Icon(IconRes.home),
              onPressed: () => context.goBackToFirstPage(),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(child: _createForm()),
            Padding(
              padding: const EdgeInsets.all(DimenRes.size_16),
              child: Button(
                enabled: _isButtonEnabled,
                label: _buttonTitle,
                onPressed: () { _save(); },
              ),
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditMode && !_isOldDataLoaded) {
      final id = widget.studentIdToEdit;
      return CustomFutureBuilder(
        future: _studentService.findById(id),
        onErrorFuture: (e, s) => context.showErrorSnackBar(StringRes.messageErrorStudentIdNotFound(id)),
        noDataWidget: _createPage(),
        onShowDataWidget: (data) {
          _setOldStudentData(data);
          return _createPage();
        },
        loadingWidget: LoadingBlocker(
          message: StringRes.loadingDetailStudent,
          toBlock: _createPage(),
        )
      );
    }
    return _createPage();
  }
}
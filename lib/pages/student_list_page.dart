import 'package:flutter/material.dart';
import 'package:sekolah_ku/model/student.dart';
import 'package:sekolah_ku/navigation/app_navigation.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/services/app_service.dart';
import 'package:sekolah_ku/util/logger.dart';
import 'package:sekolah_ku/util/navigation_extension.dart';
import 'package:sekolah_ku/util/snackbar_extension.dart';
import 'package:sekolah_ku/util/dialog_extension.dart';
import 'package:sekolah_ku/widgets/button.dart';
import 'package:sekolah_ku/widgets/container_no_data.dart';
import 'package:sekolah_ku/widgets/custom_future_builder.dart';
import 'package:sekolah_ku/widgets/dialog_filter_student.dart';
import 'package:sekolah_ku/widgets/loading_dialog.dart';
import 'package:sekolah_ku/widgets/student_list.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final _studentService = AppService.studentService;
  final _userService = AppService.userService;
  List<Student> _students = [];
  String? lastSelectedFilterGender, lastSelectedFilterEducation;
  bool get _isFilterApplied => lastSelectedFilterEducation != null || lastSelectedFilterGender != null;

  void _logout() {
    context.showLoadingDialog(
        message: StringRes.loadingLogout,
        future: _userService.logout(),
        onGetResult: (value) => context.startLoginPage(),
        onGetError: (e, s) => context.showErrorSnackBar(e.toString())
    );
  }

  void _delete(Student selected) {
    _studentService.delete(selected).then((value) => setState(() {
      _students.remove(selected);
      context.showSuccessSnackBar(StringRes.successDeleteStudent);
    })).catchError((e) => context.showErrorSnackBar(e.toString()));
  }

  void _showConfirmationDelete(Student selected) {
    context.showConfirmationDialog(
        title : StringRes.deleteStudent,
        message: StringRes.messageConfirmDeleteStudent(selected.fullName),
        cancelAble: false,
        onConfirmed: () => _delete(selected)
    );
  }

  void _showConfirmationLogout() {
    context.showConfirmationDialog(
        title: StringRes.logout,
        message: StringRes.confirmLogout,
        onConfirmed: () => _logout()
    );
  }

  void _showErrorLoadStudents() {
    if (_isFilterApplied) {
      context.showErrorSnackBar(StringRes.messageErrorFilterStudents(lastSelectedFilterGender, lastSelectedFilterEducation));
      return;
    }
    context.showErrorSnackBar(StringRes.errNoDataStudents);
  }

  void _detectItemChanged(Student oldStudent) {
    _studentService.findById(oldStudent.id).then((value) {
      if (value != oldStudent) {
        setState(() {
          final pos = _students.indexOf(oldStudent);
          _students[pos] = value;
        });
      }
    }).catchError((e, s) { _showErrorLoadStudents(); });
  }

  void _detectListChanged() {
    Future<int> future = _studentService.getTotalData();
    if (_isFilterApplied) {
      future = _studentService.countByGenderOrEducation(lastSelectedFilterGender, lastSelectedFilterEducation);
    }
    future.then((value) {
      final isDifferent = value != _students.length;
      debug("Total on db $value, current : ${_students.length}, is different ? $isDifferent");
      if (isDifferent) {
        _refresh();
      }
    }).catchError((e, s) { _showErrorLoadStudents(); });
  }

  void _detectContentChanged() async {
    final studentsOnDb = await _studentService.findAll();
    for (var studentOnView in _students) {
      final filterList = studentsOnDb.where((element) => element.id == studentOnView.id);
      if (filterList.isNotEmpty) {
        final student = filterList.first;
        if (studentOnView != student) {
          setState(() {
            final pos = _students.indexOf(studentOnView);
            _students[pos] = student;
          });
        }
      }
    }
  }

  void _refresh() {
    setState(() {
      _students.clear();
    });
  }

  Future<void> _refreshData() async {
    final founds = await _studentService.findAll();
    setState(() {
      _students = founds;
    });
  }

  void _filterStudents(String? education, String? gender) {
    if (education == null && gender == null) {
      context.showErrorSnackBar(StringRes.errFilterStudents);
      return;
    }
    lastSelectedFilterEducation = education;
    lastSelectedFilterGender = gender;
    _refresh();
  }

  void _resetFilter() {
    lastSelectedFilterGender = null;
    lastSelectedFilterEducation = null;
    _refresh();
  }

  void _showFilterDialog() {
    final content = DialogFilterStudent(
      lastSelectedEducation: lastSelectedFilterEducation,
      lastSelectedGender: lastSelectedFilterGender,
      onCancel: () => context.goBack(),
      onReset: () {
        context.goBack();
        _resetFilter();
      },
      onApply: (edu, gender) {
        context.goBack();
        _filterStudents(edu, gender);
      });
    context.showBottomSheetDialog(content);
  }

  Widget _createBody() {
    return Column(
      children: [
        if (_isFilterApplied) Container(
          color: ColorRes.green,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: DimenRes.size_16, right: DimenRes.size_16, top: DimenRes.size_6, bottom: DimenRes.size_6),
            child: Row(
              children: [
                const Expanded(child: Text(StringRes.filterApplied, style: TextStyle(color: Colors.white),)),
                const SizedBox(width: DimenRes.size_8,),
                Button(label: StringRes.resetFilter, isExpanded: false, onPressed: () => _resetFilter())
              ],
            ),
          ),
        ),
        Expanded(child: StudentList(
          students: _students,
          onEmpty: ContainerNoData(message: StringRes.errNoDataStudents, onRefreshClicked: () => _refresh()),
          onActionSelected: (action, selected) {
            switch(action) {
              case StudentListAction.showDetail:
                context.startDetailStudentPage(selected).then((value) => _detectItemChanged(selected));
                break;
              case StudentListAction.edit:
                context.startStudentFormPage(selected).then((value) => _detectItemChanged(selected));
                break;
              case StudentListAction.delete:
                _showConfirmationDelete(selected);
                break;
            }
          },
        ))
      ],
    );
  }

  Widget _createPage(List<Student> students) {
    _students = students;
    IconData iconFilter = IconRes.filter;
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringRes.appName),
        actions: [
          IconButton(onPressed: () {
            context.startStudentSearchPage()
                .then((value) => _detectContentChanged());
          }, icon: const Icon(IconRes.search)),
          IconButton(onPressed: () => _showFilterDialog(), icon: Icon(iconFilter)),
          IconButton(onPressed: () { _showConfirmationLogout(); }, icon: const Icon(IconRes.logout))
        ],
      ),
      body: RefreshIndicator(
        child: _createBody(),
        onRefresh: () => _refreshData(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          IconRes.add,
          color: ColorRes.white,
        ),
        onPressed: () {
          context.startStudentFormPage()
              .then((value) => _detectListChanged());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_students.isNotEmpty) return _createPage(_students);
    Future<List<Student>> future = _studentService.findAll();
    if (_isFilterApplied) {
      future = _studentService.findByGenderOrEducation(lastSelectedFilterGender, lastSelectedFilterEducation);
    }
    return CustomFutureBuilder<List<Student>>(
      future: future,
      onErrorFuture: (e, s) => _showErrorLoadStudents(),
      noDataWidget: _createPage([]),
      onShowDataWidget: (data) => _createPage(data),
      loadingWidget: LoadingBlocker(
        message: StringRes.loadingStudents,
        toBlock: _createPage([]),
      )
    );
  }
}
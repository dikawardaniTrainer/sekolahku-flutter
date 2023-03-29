import 'package:flutter/material.dart';
import 'package:sekolah_ku/model/student.dart';
import 'package:sekolah_ku/navigation/app_navigation.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/services/app_service.dart';
import 'package:sekolah_ku/util/logger.dart';
import 'package:sekolah_ku/util/state_extension.dart';
import 'package:sekolah_ku/util/widget_extension.dart';
import 'package:sekolah_ku/widgets/container_no_data.dart';
import 'package:sekolah_ku/widgets/custom_future_builder.dart';
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

  void _logout() {
    _userService.logout().then((value) => context.startLoginPage())
        .catchError((e) => context.showErrorSnackBar(e.toString()));
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

  void _showErrorLoadStudents() => context.showErrorSnackBar(StringRes.errNoDataStudents);

  void _detectItemChanged(Student oldStudent) {
    _studentService.findAll().then((value) {
      final latest = value.firstWhere((element) => element.id == oldStudent.id);
      if (latest != oldStudent) {
        setState(() {
          final pos = _students.indexOf(oldStudent);
          _students[pos] = latest;
        });
      }
    }).catchError((e, s) { _showErrorLoadStudents(); });
  }

  void _detectListChanged() {
    _studentService.getTotalData().then((value) {
      final isDifferent = value != _students.length;
      debug("Total on db $value, current : ${_students.length}, is different ? $isDifferent");
      if (isDifferent) {
        _refresh();
      }
    }).catchError((e, s) { _showErrorLoadStudents(); });
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

  Widget _createBody() {
    return StudentList(
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
    );
  }

  Widget _createPage(List<Student> students) {
    _students = students;
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringRes.appName),
        actions: [
          IconButton(onPressed: () {
            context.startStudentSearchPage()
                .then((value) => refresh());
          }, icon: const Icon(IconRes.search)),
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
    return CustomFutureBuilder<List<Student>>(
      future: _studentService.findAll(),
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
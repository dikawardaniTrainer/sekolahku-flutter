import 'package:flutter/material.dart';
import 'package:sekolah_ku/model/student.dart';
import 'package:sekolah_ku/navigation/app_navigation.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/services/app_service.dart';
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
      body: StudentList(
        students: _students,
        onEmpty: ContainerNoData(message: StringRes.errNoDataStudents, onRefreshClicked: () => refresh()),
        onActionSelected: (action, selected) {
          switch(action) {
            case StudentListAction.showDetail:
              context.startDetailStudentPage(selected).then((value) => refresh());
              break;
            case StudentListAction.edit:
              context.startStudentFormPage(selected).then((value) => refresh());
              break;
            case StudentListAction.delete:
              _showConfirmationDelete(selected);
              break;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          IconRes.add,
          color: ColorRes.white,
        ),
        onPressed: () {
          context.startStudentFormPage()
              .then((value) => refresh());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<List<Student>>(
      future: _studentService.findAll(),
      noDataWidget: _createPage([]),
      onShowDataWidget: (data) => _createPage(data),
      loadingWidget: LoadingBlocker(
        message: StringRes.loadingStudents,
        toBlock: _createPage([]),
      )
    );
  }
}
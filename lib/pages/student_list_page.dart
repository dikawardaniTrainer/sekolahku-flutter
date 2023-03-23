import 'package:flutter/material.dart';
import 'package:sekolah_ku/navigation/app_navigation.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/services/app_service.dart';
import 'package:sekolah_ku/util/logger.dart';
import 'package:sekolah_ku/util/state_extension.dart';
import 'package:sekolah_ku/util/widget_extension.dart';
import 'package:sekolah_ku/widgets/student_list.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final _studentService = AppService.studentService;
  final _userService = AppService.userService;

  void _logout() {
    _userService.logout().then((value) => context.startLoginPage())
        .catchError((e) => context.showErrorSnackBar(e.toString()));
  }

  void _showConfirmationLogout() {
    context.showConfirmationDialog(StringRes.logout, StringRes.confirmLogout, () {
      _logout();
    });
  }


  @override
  Widget build(BuildContext context) {
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
        onFetchingData: () => _studentService.findAll().catchError((e, s) {
          context.showErrorSnackBar(e.toString());
          debugError(e, s);
        }),
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
}
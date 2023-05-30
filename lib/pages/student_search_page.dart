import 'package:flutter/material.dart';
import 'package:sekolah_ku/model/student.dart';
import 'package:sekolah_ku/navigation/app_navigation.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/services/app_service.dart';
import 'package:sekolah_ku/util/snackbar_extension.dart';
import 'package:sekolah_ku/util/state_extension.dart';
import 'package:sekolah_ku/util/dialog_extension.dart';
import 'package:sekolah_ku/widgets/custom_future_builder.dart';
import 'package:sekolah_ku/widgets/search_bar.dart';
import 'package:sekolah_ku/widgets/student_list.dart';

class StudentSearchPage extends StatefulWidget {
  const StudentSearchPage({
    super.key
  });

  @override
  State<StudentSearchPage> createState() => _StudentSearchPageState();
}

class _StudentSearchPageState extends State<StudentSearchPage> {
  final _studentService = AppService.studentService;
  final _searchCtrl = TextEditingController();
  List<Student> _students = [];

  void _delete(Student selected) {
    _studentService.delete(selected)
        .then((value) => setState(() {
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

  Widget _showStudents(List<Student> students) {
    _students = students;
    return StudentList(
      students: _students,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppSearchBar(
            controller: _searchCtrl,
            onValueChanged: (s) { setState(() {}); },
            onClearTapped: () { setState(() {}); },
          ),
          automaticallyImplyLeading: false,
        ),
        body: CustomFutureBuilder<List<Student>>(
            future: _studentService.findByName(_searchCtrl.text),
            noDataWidget: _showStudents([]),
            onShowDataWidget: (data) => _showStudents(data),
            loadingWidget: _showStudents([])
        )
    );
  }
}
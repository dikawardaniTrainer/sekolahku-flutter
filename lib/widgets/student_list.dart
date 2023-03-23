import 'package:flutter/material.dart';
import 'package:sekolah_ku/navigation/app_navigation.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/services/app_service.dart';
import 'package:sekolah_ku/util/context_extension.dart';
import 'package:sekolah_ku/util/state_extension.dart';
import 'package:sprintf/sprintf.dart';

import '../model/student.dart';
import 'container_no_data.dart';
import 'item_synopsis_student.dart';

typedef OnGetService<T> = T Function();

class StudentList extends StatefulWidget {
  final OnGetService<Future<List<Student>>> onFetchingData;

  const StudentList({
    super.key,
    required this.onFetchingData
  });
  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final _studentService = AppService.studentService;
  final List<Student> _students = [];

  void _delete(Student selected) {
    _studentService.delete(selected)
        .then((value) => setState(() {
          _students.remove(selected);
          context.showSuccessSnackBar(StringRes.successDeleteStudent);
        })).catchError((e) => context.showErrorSnackBar(e.toString()));
  }

  void _showConfirmationDelete(Student selected) {
    context.showConfirmationDialog(StringRes.deleteStudent, sprintf(StringRes.confirmDeleteStudent, [selected.fullName]), () {
      _delete(selected);
    });
  }

  void _executeSelectedAction(String action, Student selected) {
    if (action == StringRes.edit) {
      context.startStudentFormPage(selected)
          .then((value) => refresh());
      return;
    }
    if (action == StringRes.delete) {
      _showConfirmationDelete(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Student>>(
      future: widget.onFetchingData.call(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data != null) {
          _students.clear();
          _students.addAll(data);
          if (data.isEmpty) {
            return const ContainerNoData(message: StringRes.errNoDataStudents);
          }
          return ListView.separated(
            padding: const EdgeInsets.only(top: DimenRes.size_16),
            itemCount: _students.length,
            separatorBuilder: (context, i) => const Divider(color: ColorRes.teal, height: DimenRes.size_1),
            itemBuilder: (context, i) {
              final student = _students[i];
              return ItemSynopsisStudent(
                student: student,
                onTap: () { context.startDetailStudentPage(student).then((value) => refresh()); },
                onActionSelected: (action, student) {
                  _executeSelectedAction(action, student);
                },
              );
            },
          );
        }

        return const ContainerNoData(message: StringRes.errNoDataStudents);
      },
    );
  }
}
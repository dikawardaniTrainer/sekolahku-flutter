import 'package:flutter/material.dart';
import 'package:sekolah_ku/model/student.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/widgets/container_no_data.dart';
import 'package:sekolah_ku/widgets/item_synopsis_student.dart';

enum StudentListAction {
  showDetail,
  edit,
  delete
}

typedef OnActionSelected = Function(StudentListAction action, Student selected);

class StudentList extends StatelessWidget {
  final List<Student> students;
  final OnActionSelected onActionSelected;
  final Widget onEmpty;

  const StudentList({
    super.key,
    required this.students,
    required this.onActionSelected,
    this.onEmpty = const ContainerNoData(message: StringRes.errNoDataStudents)
  });

  void _executeSelectedAction(String action, Student selected) {
    if (action == StringRes.edit) {
      onActionSelected.call(StudentListAction.edit, selected);
      return;
    }
    if (action == StringRes.delete) {
      onActionSelected.call(StudentListAction.delete, selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (students.isEmpty) {
      return onEmpty;
    }
    return ListView.separated(
      padding: const EdgeInsets.only(top: DimenRes.size_16),
      itemCount: students.length,
      separatorBuilder: (context, i) =>
      const Divider(color: ColorRes.teal, height: DimenRes.size_1),
      itemBuilder: (context, i) {
        final student = students[i];
        return ItemSynopsisStudent(
          student: student,
          onTap: () => onActionSelected.call(StudentListAction.showDetail, student),
          onActionSelected: (action, student) {
            _executeSelectedAction(action, student);
          },
        );
      },
    );
  }
}

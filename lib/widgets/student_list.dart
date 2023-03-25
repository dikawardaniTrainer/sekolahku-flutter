import 'package:flutter/material.dart';
import 'package:sekolah_ku/model/student.dart';
import 'package:sekolah_ku/navigation/app_navigation.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/services/app_service.dart';
import 'package:sekolah_ku/util/state_extension.dart';
import 'package:sekolah_ku/util/widget_extension.dart';
import 'package:sekolah_ku/widgets/container_no_data.dart';
import 'package:sekolah_ku/widgets/custom_future_builder.dart';
import 'package:sekolah_ku/widgets/item_synopsis_student.dart';
import 'package:sekolah_ku/widgets/loading_dialog.dart';

typedef OnGetService<T> = T Function();

class StudentList extends StatefulWidget {
  final OnGetService<Future<List<Student>>> onFetchingData;
  final OnErrorFuture? onErrorFuture;

  const StudentList({
    super.key,
    required this.onFetchingData,
    this.onErrorFuture
  });
  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> with TickerProviderStateMixin {
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
    context.showConfirmationDialog(
        title : StringRes.deleteStudent,
        message: StringRes.messageConfirmDeleteStudent(selected.fullName),
        cancelAble: false,
        onConfirmed: () => _delete(selected)
    );
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

  Widget _getWidgetData(List<Student> students) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: DimenRes.size_16),
      itemCount: _students.length,
      separatorBuilder: (context, i) =>
      const Divider(color: ColorRes.teal, height: DimenRes.size_1),
      itemBuilder: (context, i) {
        final student = _students[i];
        return ItemSynopsisStudent(
          student: student,
          onTap: () {
            context.startDetailStudentPage(student).then((value) =>
                refresh());
          },
          onActionSelected: (action, student) {
            _executeSelectedAction(action, student);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: widget.onFetchingData.call(),
      loadingWidget: const LoadingDialog(message: StringRes.loadingStudents),
      noDataWidget: ContainerNoData(message: StringRes.errNoDataStudents, onRefreshClicked: () => refresh()),
      onErrorFuture: widget.onErrorFuture,
      onShowDataWidget: (data) {
        _students.clear();
        _students.addAll(data);
        return _getWidgetData(_students);
      }
    );
  }
}
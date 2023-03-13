import 'package:flutter/cupertino.dart';
import 'package:sekolah_ku/pages/login_page.dart';
import 'package:sekolah_ku/util/context_extension.dart';

import '../model/student.dart';
import '../pages/student_detail_page.dart';
import '../pages/student_form_page.dart';
import '../pages/student_list_page.dart';
import '../pages/student_search_page.dart';

extension AppNavigation on BuildContext {
  Future<dynamic> startStudentSearchPage() => goToPage(const StudentSearchPage(), isScreenDialog: true);

  Future<dynamic> startAddNewStudentPage() => goToPage(const StudentFormPage());

  Future<dynamic> startDetailStudentPage(Student selectedStudent) => goToPage(StudentDetailPage(id: selectedStudent.id));

  Future<dynamic> startEditStudentPage(Student selectedStudent) => goToPage(StudentFormPage(studentIdToEdit: selectedStudent.id));

  Future<dynamic> startStudentListPage() => goToPage(const StudentListPage(), isRootPage: true);

  Future<dynamic> startLoginPage() => goToPage(const LoginPage(), isRootPage: true);
}
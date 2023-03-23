import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sekolah_ku/model/student.dart';
import 'package:sekolah_ku/pages/login_page.dart';
import 'package:sekolah_ku/pages/student_detail_page.dart';
import 'package:sekolah_ku/pages/student_form_page.dart';
import 'package:sekolah_ku/pages/student_list_page.dart';
import 'package:sekolah_ku/pages/student_search_page.dart';
import 'package:sekolah_ku/util/context_extension.dart';

class Routes {
  static const login = "/login";
  static const studentList = "/studentList";
  static const studentForm = "/studentForm";
  static const studentDetail = "/studentDetail";
  static const studentSearch = "/studentSearch";
}

class Args {
  final bool isScreenDialog;
  Object? data;

  Args({
    required this.isScreenDialog,
    this.data
  });
}

extension AppNavigation on BuildContext {
  Future<dynamic> _goToPage(
      String route,
      {bool isRootPage = false, bool isScreenDialog = false, Object? data}
  ) => goToPageWithRouteName(route, isRootPage: isRootPage, Args(isScreenDialog: isScreenDialog, data: data));

  Future<dynamic> startStudentSearchPage() => _goToPage(Routes.studentSearch, isScreenDialog: true);

  Future<dynamic> startDetailStudentPage(Student selectedStudent) => _goToPage(Routes.studentDetail, data: selectedStudent.id);

  Future<dynamic> startStudentFormPage([Student? selectedStudent]) => _goToPage(Routes.studentForm, data: selectedStudent?.id);

  Future<dynamic> startStudentListPage() => _goToPage(Routes.studentList, isRootPage: true);

  Future<dynamic> startLoginPage() => _goToPage(Routes.login, isRootPage: true);

  Widget? _getPage(String? routeName, Args args) {
    switch(routeName) {
      case Routes.studentList : return const StudentListPage();
      case Routes.studentSearch: return const StudentSearchPage();
      case Routes.login: return const LoginPage();
      case Routes.studentDetail:
        final data = args.data;
        if (data is int) {
          return StudentDetailPage(id: data);
        }
        return null;
      case Routes.studentForm:
        final data = args.data;
        if (data is int) {
          return StudentFormPage(studentIdToEdit: data);
        }
        return const StudentFormPage();
      default: return null;
    }
  }

  RouteFactory getRouteGenerator() => (settings) {
    final arg = settings.arguments;
    if (arg is Args) {
      final destination = _getPage(settings.name, arg);
      if (destination != null) {
        return createRoute(destination, isScreenDialog: arg.isScreenDialog);
      }
    }
    FlutterNativeSplash.remove();
    return null;
  };
}
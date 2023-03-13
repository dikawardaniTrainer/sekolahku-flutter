import 'package:flutter/material.dart';
import 'package:sekolah_ku/pages/login_page.dart';
import 'package:sekolah_ku/pages/student_list_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/font_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/services/app_service.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _userService = AppService.userService;

  MyApp({super.key});

  Future<Widget> _determineFirstPage() {
    return Future(() async {
      Widget firstScreen = const LoginPage();
      final isLoggedIn = await _userService.isLoggedIn();

      if (isLoggedIn) {
        firstScreen = const StudentListPage();
      }

      FlutterNativeSplash.remove();
      return firstScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringRes.appName,
      theme: ThemeData(
        primarySwatch: ColorRes.tealMat,
        fontFamily: FontRes.poppins
      ),
      home: FutureBuilder<Widget>(
          future: _determineFirstPage(),
          builder: (context, snapshot) {
            final widget = snapshot.data;
            if (widget != null) {
              return widget;
            }
            return const LoginPage();
          }
      )
    );
  }
}

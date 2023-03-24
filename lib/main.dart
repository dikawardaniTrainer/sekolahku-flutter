import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sekolah_ku/navigation/app_navigation.dart';
import 'package:sekolah_ku/navigation/routes.dart';
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

  Widget _startApp(BuildContext context, bool? isLoggedIn) {
    String? initialRoute = isLoggedIn != null && isLoggedIn ? Routes.studentList : Routes.login;
    return MaterialApp(
      title: StringRes.appName,
      onGenerateRoute: context.getRouteGenerator(),
      initialRoute: initialRoute,
      theme: ThemeData(
          primarySwatch: ColorRes.tealMat,
          fontFamily: FontRes.poppins
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _userService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final isLoggedIn = snapshot.data;
          FlutterNativeSplash.remove();
          return _startApp(context, isLoggedIn);
        }
        return Container();
      });
  }
}

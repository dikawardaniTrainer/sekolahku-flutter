import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sekolah_ku/navigation/app_navigation.dart';
import 'package:sekolah_ku/navigation/routes.dart';
import 'package:sekolah_ku/pages/login/bloc/login_bloc.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/resources/theme_res.dart';
import 'package:sekolah_ku/services/app_service.dart';
import 'package:sekolah_ku/widgets/custom_future_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final _userService = AppService.userService;

  Widget _startApp(BuildContext context, bool? isLoggedIn) {
    String? initialRoute = isLoggedIn != null && isLoggedIn ? Routes.studentList : Routes.login;
    return MaterialApp(
      title: StringRes.appName,
      onGenerateRoute: context.getRouteGenerator(),
      initialRoute: initialRoute,
      themeMode: ThemeRes.themeMode,
      darkTheme: ThemeRes.getTheme(true),
      theme: ThemeRes.getTheme(false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleFutureBuilder<bool>(
        future: _userService.isLoggedIn(),
        onShowDataWidget: (isLoggedIn) {
          FlutterNativeSplash.remove();
          return _startApp(context, isLoggedIn);
        },
        noDataWidget: Container()
    );
  }

}

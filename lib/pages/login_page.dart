import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sekolah_ku/constant/validation_const.dart';
import 'package:sekolah_ku/model/user.dart';
import 'package:sekolah_ku/navigation/app_navigation.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/services/app_service.dart';
import 'package:sekolah_ku/util/logger.dart';
import 'package:sekolah_ku/util/widget_extension.dart';
import 'package:sekolah_ku/widgets/banner_header.dart';
import 'package:sekolah_ku/widgets/button.dart';
import 'package:sekolah_ku/widgets/dropdown.dart';
import 'package:sekolah_ku/widgets/input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userService = AppService.userService;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final DropDownController<Role?> _roleCtrl = DropDownController(null);

  var obscureText = true;
  var iconData = IconRes.eye;
  List<Role> _roles = [];

  String? _validateEmail(String? email) {
    if (email != null) {
      if (email.isEmpty) {
        return StringRes.errEmailEmpty;
      }
      final bool emailValid = regexEmail.hasMatch(email);
      if (!emailValid) {
        return StringRes.errEmailInvalid;
      }
    }

    return null;
  }

  String? _validatePassword(String? password) {
    if (password != null) {
      if (password.isEmpty) {
        return StringRes.errPasswordEmpty;
      }
      if (password.length < 6) {
        return StringRes.errPasswordInvalid;
      }
    }
    return null;
  }

  String? _validateRole(Role? role) {
    if (role == null) {
      return StringRes.errRoleRequired;
    }
    return null;
  }

  void _login() {
    final isValid = _formKey.currentState?.validate();
    final username = _usernameCtrl.text;
    final password = _passwordCtrl.text;
    final role = _roleCtrl.value;

    if (isValid != null && isValid && role != null) {
      _userService.login(username, password, role).then((value) => context.startStudentListPage())
          .catchError((e, s) {
            context.showErrorSnackBar(e.toString());
            debugError(e, s);
          });
    } else {
      context.showErrorSnackBar(StringRes.errSomeInputInvalid);
    }
  }

  void _updatePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
      if (obscureText) {
        iconData = IconRes.eye;
      } else {
        iconData = IconRes.eyeSlash;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _userService.getRoles().then((value) {
      setState(() {
        _roles = value;
      });
    });
    if (kDebugMode) {
      _usernameCtrl.text = "admin@rc.com";
      _passwordCtrl.text = "admin1";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const BannerHeader(
                    iconData: IconRes.education,
                    title: StringRes.appName
                ),
                Padding(
                    padding: const EdgeInsets.all(DimenRes.size_16),
                    child: Column(
                      children: [
                        InputField(
                            label: StringRes.username,
                            controller: _usernameCtrl,
                            prefixIcon: const Icon(IconRes.personOutline, color: ColorRes.teal),
                            validator: (input) {
                              return _validateEmail(input);
                            },
                            textInputType: TextInputType.emailAddress),
                        InputField(
                          label: StringRes.password,
                          controller: _passwordCtrl,
                          prefixIcon: const Icon(IconRes.lock, color: ColorRes.teal),
                          marginTop: DimenRes.size_16,
                          validator: (input) {
                            return _validatePassword(input);
                          },
                          textInputType: TextInputType.text,
                          obscureText: obscureText,
                          suffixIcon: IconButton(
                              icon: Icon(iconData),
                              color: ColorRes.teal,
                              onPressed: () { _updatePasswordVisibility(); }
                          ),
                        ),
                        DropDown<Role?>(
                            options: _roles,
                            controller: _roleCtrl,
                            label: StringRes.role,
                            onDrawItem: (item) => Text(item != null ? item.name : ""),
                            marginTop: DimenRes.size_16,
                            validator: (s) { return _validateRole(s); },
                            onChanged: (v) { _roleCtrl.value = v; }),
                        Button(
                            label: StringRes.login,
                            marginTop: DimenRes.size_16,
                            onPressed: () {
                              _login();
                            })
                      ],
                    )
                )
              ],
            ),
          ))
    );
  }
}

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
import 'package:sekolah_ku/util/widget_extension.dart';
import 'package:sekolah_ku/widgets/banner_header.dart';
import 'package:sekolah_ku/widgets/button.dart';
import 'package:sekolah_ku/widgets/custom_future_builder.dart';
import 'package:sekolah_ku/widgets/dropdown.dart';
import 'package:sekolah_ku/widgets/input.dart';
import 'package:sekolah_ku/widgets/loading_dialog.dart';

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

  List<Role> _roles = [];
  var _obscureText = true;
  var _iconData = IconRes.eye;
  bool get _isContentLoaded => _roles.isNotEmpty;

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
      context.showLoadingDialog(
        message: StringRes.loadingLogin,
        future: _userService.login(username, password, role),
        onGetError: (e, s) => context.showErrorSnackBar(e.toString()),
        onGetResult: (data) => context.startStudentListPage()
      );
    } else {
      context.showErrorSnackBar(StringRes.errSomeInputInvalid);
    }
  }

  void _updatePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText) {
        _iconData = IconRes.eye;
      } else {
        _iconData = IconRes.eyeSlash;
      }
    });
  }

  Widget _createForm(List<Role> roles) {
    return SingleChildScrollView(
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
                        obscureText: _obscureText,
                        suffixIcon: IconButton(
                            icon: Icon(_iconData),
                            color: ColorRes.teal,
                            onPressed: () { _updatePasswordVisibility(); }
                        ),
                      ),
                      DropDown<Role?>(
                          options: roles,
                          controller: _roleCtrl,
                          label: StringRes.role,
                          onDrawItem: (item) => Text(item != null ? item.name : ""),
                          marginTop: DimenRes.size_16,
                          validator: (s) { return _validateRole(s); },
                          onChanged: (v) { _roleCtrl.value = v; })
                    ],
                  )
              )
            ],
          ),
        ));
  }

  Widget _createPage(List<Role> roles) {
    _roles = roles;
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _createForm(roles)),
          Padding(
            padding: const EdgeInsets.all(DimenRes.size_16),
            child: Button(
              label: StringRes.login,
              marginTop: DimenRes.size_16,
              onPressed: () => _login(),
              enabled: _isContentLoaded,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      _usernameCtrl.text = "admin@rc.com";
      _passwordCtrl.text = "admin1";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isContentLoaded) return _createPage(_roles);
    return CustomFutureBuilder<List<Role>>(
      future: _userService.getRoles(),
      onShowDataWidget: (data) => _createPage(data),
      noDataWidget: _createPage([]),
      onErrorFuture: (e, s) => context.showErrorSnackBar(StringRes.errFetchRoles),
      loadingWidget: LoadingBlocker(
        message: StringRes.loadingContents,
        toBlock: _createPage([]),
      )
    );
  }
}

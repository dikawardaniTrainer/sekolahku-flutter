import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_ku/di/app_injector.dart';
import 'package:sekolah_ku/model/user.dart';
import 'package:sekolah_ku/navigation/app_navigation.dart';
import 'package:sekolah_ku/pages/login/bloc/login_bloc.dart';
import 'package:sekolah_ku/pages/login/bloc/login_event.dart';
import 'package:sekolah_ku/pages/login/bloc/login_state.dart';
import 'package:sekolah_ku/pages/login/bloc/login_status.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/util/form_ext.dart';
import 'package:sekolah_ku/util/logger.dart';
import 'package:sekolah_ku/util/navigation_extension.dart';
import 'package:sekolah_ku/util/snackbar_extension.dart';
import 'package:sekolah_ku/widgets/banner_header.dart';
import 'package:sekolah_ku/widgets/button.dart';
import 'package:sekolah_ku/widgets/dropdown.dart';
import 'package:sekolah_ku/widgets/input_email.dart';
import 'package:sekolah_ku/widgets/input_password.dart';
import 'package:sekolah_ku/widgets/loading_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final DropDownController<Role?> _roleCtrl = DropDownController(null);
  final _loginBloc = AppInjector.loginBloc;
  bool _isShowingLoading = false;

  String? _validateRole(Role? role) {
    if (role == null) {
      return StringRes.errRoleRequired;
    }
    return null;
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
                      InputEmailField(
                        label: StringRes.username,
                        controller: _usernameCtrl,
                        prefixIcon: const Icon(IconRes.personOutline, color: ColorRes.teal),
                        onChanged: (input) {
                          _loginBloc.add(UsernameChanged(username: input));
                        },
                      ),
                      InputPasswordField(
                        marginTop: DimenRes.size_16,
                        controller: _passwordCtrl,
                        prefixIcon: const Icon(IconRes.lock, color: ColorRes.teal),
                        onChanged: (input) {
                          _loginBloc.add(PasswordChanged(password: input));
                        },
                      ),
                      DropDown<Role?>(
                          options: roles,
                          controller: _roleCtrl,
                          label: StringRes.role,
                          onDrawItem: (item) => Text(item != null ? item.name : ""),
                          marginTop: DimenRes.size_16,
                          validator: (s) { return _validateRole(s); },
                          onChanged: (v) {
                            _roleCtrl.value = v;
                            _loginBloc.add(RoleChanged(role: v));
                            debug("Ganti role  to ${v.toString()}");
                          })
                    ],
                  )
              )
            ],
          ),
        ));
  }

  Widget _createPage(List<Role> roles) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _createForm(roles)),
          Padding(
            padding: const EdgeInsets.all(DimenRes.size_16),
            child: Button(
              label: StringRes.login,
              marginTop: DimenRes.size_16,
              isFormAction: true,
              onPressed: () => _loginBloc.add(Submit()),
              enabled: roles.isNotEmpty && _formKey.isAllInputValid,
            ),
          )
        ],
      ),
    );
  }

  void _showError(Exception err) {
    if (_isShowingLoading) {
      context..goBack()
        ..showErrorSnackBar(err.toString());
      _isShowingLoading = false;
      return;
    }
    context.showErrorSnackBar(err.toString());
  }

  void _listen(BuildContext context, LoginState state) {
    final status = state.loginStatus;

    if (status is GetRolesSuccess && _isShowingLoading) {
      context.goBack();
      _isShowingLoading = false;
      return;
    }

    if (status is GetRolesFailed) {
      _showError(status.err);
      return;
    }

    if (status is LoginSuccess) {
      if (_isShowingLoading) {
        context..goBack()
          ..startStudentListPage();
        _isShowingLoading = false;
        return;
      }
      context.startStudentListPage();
      return;
    }
    if (status is LoginFailed) {
      _showError(status.err);
      return;
    }
  }

  Widget _createByState(LoginState state) {
    final status = state.loginStatus;

    if (status is LoadingLogin || status is LoadingGetRoles) {
      String message = StringRes.loadingLogin;
      if (status is LoadingGetRoles) message = StringRes.loadingContents;

      return LoadingBlocker(
        message: message,
        toBlock: _createPage(state.roleOptions),
      );
    }
    return _createPage(state.roleOptions);
  }

  @override
  void initState() {
    super.initState();
    _loginBloc.add(LoadRoles());
    if (kDebugMode) {
      _usernameCtrl.text = "admin@rc.com";
      _passwordCtrl.text = "admin1";
      _loginBloc.add(SetDefaultUser(_usernameCtrl.text, _passwordCtrl.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: _loginBloc,
      builder: (c, state) => _createByState(state),
      listener: (c, state) => _listen(c, state)
    );
  }
}

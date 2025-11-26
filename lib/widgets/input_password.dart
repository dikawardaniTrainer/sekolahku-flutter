import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/widgets/input.dart';

class InputPasswordField extends StatefulWidget {
  final double marginTop;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const InputPasswordField({
    super.key,
    this.marginTop = DimenRes.size_0,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.onChanged
  });

  @override
  State<InputPasswordField> createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  var _obscureText = true;
  var _iconData = IconRes.eye;

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

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: StringRes.password,
      controller: widget.controller,
      prefixIcon: widget.prefixIcon,
      marginTop: DimenRes.size_16,
      validator: (input) {
        return _validatePassword(input);
      },
      textInputType: TextInputType.text,
      maxLine: 1,
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      suffixIcon: IconButton(
          icon: Icon(_iconData),
          color: ColorRes.teal,
          onPressed: () { _updatePasswordVisibility(); }
      ),
    );
  }
}
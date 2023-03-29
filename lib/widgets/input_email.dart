import 'package:flutter/material.dart';
import 'package:sekolah_ku/constant/validation_const.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/widgets/input.dart';

class InputEmailField extends StatelessWidget {
  final String label;
  final double marginTop;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const InputEmailField({
    super.key,
    required this.label,
    this.marginTop = DimenRes.size_0,
    this.suffixIcon,
    this.controller,
    this.prefixIcon,
    this.onChanged
  });

  String? _validateEmail(String? input) {
    if (input != null) {
      if (input.isEmpty) {
        return StringRes.errEmailEmpty;
      }
      final bool emailValid = regexEmail.hasMatch(input);
      if (!emailValid) {
        return StringRes.errEmailInvalid;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: label,
      textInputType: TextInputType.emailAddress,
      validator: (s) => _validateEmail(s),
      marginTop: marginTop,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      controller: controller,
      onChanged: onChanged,
    );
  }
}

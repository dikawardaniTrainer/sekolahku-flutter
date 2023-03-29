import 'package:flutter/material.dart';
import 'package:sekolah_ku/constant/validation_const.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/widgets/input.dart';

class InputPhoneNumberField extends StatelessWidget {
  final double marginTop;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const InputPhoneNumberField({
    super.key,
    this.marginTop = DimenRes.size_0,
    this.suffixIcon,
    this.controller,
    this.prefixIcon,
    this.onChanged
  });

  String? _validatePhoneNumber(String? input) {
    if (input != null) {
      if (input.isEmpty) {
        return StringRes.errPhoneNumberEmpty;
      }
      final bool isValid = regexPhoneNumber.hasMatch(input);
      if (!isValid) {
        return StringRes.errPhoneNumberInvalid;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: StringRes.phoneNumber,
      maxLine: 1,
      textInputType: TextInputType.phone,
      validator: (s) => _validatePhoneNumber(s),
      controller: controller,
      marginTop: marginTop,
      onChanged: onChanged,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }

}
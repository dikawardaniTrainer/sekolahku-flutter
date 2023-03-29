import 'package:flutter/material.dart';
import 'package:sekolah_ku/constant/validation_const.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/widgets/input.dart';
import 'package:sprintf/sprintf.dart';

class InputNameField extends StatelessWidget {
  final String label;
  final double marginTop;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const InputNameField({
    super.key,
    required this.label,
    this.marginTop = DimenRes.size_0,
    this.suffixIcon,
    this.controller,
    this.prefixIcon,
    this.onChanged
  });

  _isContainSpecialCharacter(String input) {
    var contained = false;
    for(int i=0; i<forbiddenCharacters.length; i++) {
      if (input.contains(forbiddenCharacters[i])) {
        contained = true;
        break;
      }
    }

    return contained;
  }

  String? _validateName(String? input) {
    if (input != null) {
      if (input.isEmpty) {
        return sprintf(StringRes.errFieldEmpty, [label]);
      }

      var regexValid = regexName.hasMatch(input);
      if (!regexValid | _isContainSpecialCharacter(input)) {
        return StringRes.errSpecialCharacter;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: label,
      maxLine: 1,
      marginTop: marginTop,
      textInputType: TextInputType.text,
      controller: controller,
      validator: (s) => _validateName(s),
      onChanged: (v) => onChanged,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }

}
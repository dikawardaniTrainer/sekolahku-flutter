import 'package:flutter/material.dart';
import 'package:sekolah_ku/constant/student_const.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/widgets/dropdown.dart';

class InputEducation extends StatelessWidget {
  final double marginTop;
  final DropDownController<String> controller;
  final ValueChanged<String>? onChanged;
  final bool enableValidator;

  const InputEducation({
    super.key,
    required this.controller,
    this.marginTop = 0,
    this.onChanged,
    this.enableValidator = true
  });

  String? _validateEducation(String? input) {
    if (!enableValidator) return null;
    if (input != null) {
      if (controller.value == educationOptions.first) {
        return StringRes.errEducationEmpty;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DropDown<String>(
        label: StringRes.education,
        controller: controller,
        options: educationOptions,
        onDrawItem: (item) => Text(item),
        marginTop: marginTop,
        validator: (s) => _validateEducation(s),
        onChanged: (s) => onChanged?.call(s)
    );
  }
}
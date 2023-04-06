import 'package:flutter/material.dart';
import 'package:sekolah_ku/constant/student_const.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/widgets/radio_group.dart';

class RadioGender extends StatelessWidget {
  final double marginTop;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const RadioGender({
    super.key,
    required this.controller,
    this.marginTop = 0,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioGroup(
      label: StringRes.gender,
      controller: controller,
      options: genderOptions,
      onChanged: (s) => onChanged?.call(s),
      marginTop: marginTop,
    );
  }
}

class RadioGenderFilter extends StatelessWidget {
  final double marginTop;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const RadioGenderFilter({
    super.key,
    required this.controller,
    this.marginTop = 0,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    final options = ["Both"];
    options.addAll(genderOptions);
    return RadioGroup(
      label: StringRes.gender,
      controller: controller,
      options: options,
      onChanged: (s) => onChanged?.call(s),
      marginTop: marginTop,
      orientation: RadioOrientation.vertical,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/widgets/input.dart';

typedef OnGetErrorMessage = String Function();

class InputRequiredField extends StatelessWidget {
  final String label;
  final double marginTop;
  final Widget? suffixIcon, prefixIcon;
  final int? maxLine, minLine;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final OnGetErrorMessage onGetErrorMessage;

  const InputRequiredField({
    super.key,
    required this.label,
    required this.onGetErrorMessage,
    this.textInputType = TextInputType.text,
    this.marginTop = DimenRes.size_0,
    this.maxLine,
    this.minLine,
    this.suffixIcon,
    this.controller,
    this.prefixIcon,
    this.onChanged
  });

  String? _validateInput(String? input) {
    if (input != null) {
      if (input.isEmpty) {
        return onGetErrorMessage.call();
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: label,
      minLine: minLine,
      maxLine: maxLine,
      textInputType: textInputType,
      validator: (s) => _validateInput(s),
      marginTop: marginTop,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      controller: controller,
      onChanged: onChanged,
    );
  }

}
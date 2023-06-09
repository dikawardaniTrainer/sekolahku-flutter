import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';

class InputField extends StatelessWidget {
  final String label;
  final FormFieldValidator<String>? validator;
  final TextInputType textInputType;
  final double marginTop;
  final int? maxLine, minLine;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final VoidCallback? onTap;

  const InputField({
    super.key,
    required this.label,
    required this.textInputType,
    this.marginTop = DimenRes.size_0,
    this.validator,
    this.maxLine,
    this.minLine,
    this.suffixIcon,
    this.controller,
    this.prefixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.onChanged,
    this.focusNode,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (marginTop > DimenRes.size_0) SizedBox(height: marginTop),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: textInputType,
          validator: validator,
          maxLines: maxLine,
          controller: controller,
          obscureText: obscureText,
          readOnly: readOnly,
          enabled: enabled,
          onChanged: onChanged,
          focusNode: focusNode,
          onTap: onTap,
          minLines: minLine,
          decoration: InputDecoration(
            label: Text(label),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon
          ),
        )
      ],
    );
  }
}

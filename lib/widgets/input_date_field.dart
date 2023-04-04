import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/util/date_extension.dart';
import 'package:sekolah_ku/util/dialog_extension.dart';
import 'package:sekolah_ku/widgets/input.dart';

enum ErrorType {
 required,
 minDateReached,
 maxDateReached,
 invalid
}

typedef OnGetErrorMessage = String Function(ErrorType caused);

class InputDateField extends StatelessWidget {
  final String label;
  final double marginTop;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final OnGetErrorMessage onShowError;
  final DateTime minDate, maxDate, minDatePicker, maxDatePicker;

  const InputDateField({
    super.key,
    required this.label,
    required this.onShowError,
    required this.minDate,
    required this.maxDate,
    required this.minDatePicker,
    required this.maxDatePicker,
    this.marginTop = DimenRes.size_0,
    this.controller,
    this.prefixIcon,
    this.onChanged,
  });

  String? validateDate(String? input) {
    if (input != null) {
      if (input.isEmpty) {
        return onShowError.call(ErrorType.required);
      }

      final dateTime = input.parse();
      if (dateTime != null) {
        if (dateTime.isBefore(minDate)) {
          return onShowError.call(ErrorType.minDateReached);
        }
        if (dateTime.isAfter(maxDate)) {
          return onShowError.call(ErrorType.maxDateReached);
        }
      } else {
        return onShowError.call(ErrorType.invalid);
      }
    }

    return null;
  }

  void _showDatePickerDialog(BuildContext context) {
    var initialDate = DateTime.now();

    final text = controller?.text ?? StringRes.emptyString ;
    if (text.isNotEmpty) {
      final date = text.parse();
      if (date != null) {
        initialDate = date;
      }
    }
    context.showDatePickerDialog(
        initial: initialDate,
        limitFirstDate: minDatePicker,
        limitLastDate: maxDatePicker
    ).then((value) {
      if (value != null) {
        controller?.value = TextEditingValue(text: value.format());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: label,
      controller: controller,
      readOnly: true,
      maxLine: 1,
      textInputType: TextInputType.none,
      validator: (s) => validateDate(s),
      marginTop: marginTop,
      onChanged: onChanged,
      prefixIcon: prefixIcon,
      onTap: () => _showDatePickerDialog(context),
      suffixIcon: IconButton(
        icon: Icon(Icons.date_range , color: Theme.of(context).primaryColor),
        onPressed: () => _showDatePickerDialog(context),
      ),
    );
  }
}
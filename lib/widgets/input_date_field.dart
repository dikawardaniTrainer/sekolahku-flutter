import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/util/date_extension.dart';
import 'package:sekolah_ku/util/widget_extension.dart';
import 'package:sekolah_ku/widgets/input.dart';

enum ErrorType {
 required,
 minDateReached,
 maxDateReached,
 invalid
}

class DateConfig {
  final DateTime minDate, maxDate, minDatePicker, maxDatePicker;

  const DateConfig({
    required this.minDate,
    required this.maxDate,
    required this.minDatePicker,
    required this.maxDatePicker
  });
}

typedef OnShowError = String Function(ErrorType caused);

class InputDateField extends StatefulWidget {
  final String label;
  final double marginTop;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final DateConfig config;
  final OnShowError onShowError;

  const InputDateField({
    super.key,
    required this.label,
    required this.config,
    required this.onShowError,
    this.marginTop = DimenRes.size_0,
    this.controller,
    this.prefixIcon,
    this.onChanged
  });

  @override
  State<InputDateField> createState() => _InputDateFieldState();
}

class _InputDateFieldState extends State<InputDateField> {

  String? validateDate(String? input) {
    if (input != null) {
      if (input.isEmpty) {
        return widget.onShowError.call(ErrorType.required);
      }

      final dateTime = input.parse();
      if (dateTime != null) {
        if (dateTime.isBefore(widget.config.minDate)) {
          return widget.onShowError.call(ErrorType.minDateReached);
        }
        if (dateTime.isAfter(widget.config.maxDate)) {
          return widget.onShowError.call(ErrorType.maxDateReached);
        }
      } else {
        return widget.onShowError.call(ErrorType.invalid);
      }
    }

    return null;
  }

  void _showDatePickerDialog(BuildContext context) {
    var initialDate = DateTime.now();

    final text = widget.controller?.text ?? StringRes.emptyString ;
    if (text.isNotEmpty) {
      final date = text.parse();
      if (date != null) {
        initialDate = date;
      }
    }

    context.showDatePickerDialog(
        initial: initialDate,
        limitFirstDate: widget.config.minDatePicker,
        limitLastDate: widget.config.maxDatePicker
    ).then((value) {
      if (value != null) {
        widget.controller?.value = TextEditingValue(text: value.format());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: widget.label,
      controller: widget.controller,
      readOnly: true,
      textInputType: TextInputType.none,
      validator: (s) => validateDate(s),
      marginTop: widget.marginTop,
      onChanged: widget.onChanged,
      prefixIcon: widget.prefixIcon,
      onTap: () => _showDatePickerDialog(context),
      suffixIcon: IconButton(
        icon: Icon(Icons.date_range , color: Theme.of(context).primaryColor),
        onPressed: () => _showDatePickerDialog(context),
      ),
    );
  }
}
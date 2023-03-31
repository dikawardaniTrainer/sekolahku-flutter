
import 'package:flutter/material.dart';

extension FormExt on GlobalKey<FormState> {
  bool get isAllInputValid {
    final isValid = currentState?.validate();
    return isValid != null && isValid;
  }
}
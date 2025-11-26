import 'package:flutter/material.dart';

extension KeyboardExt on BuildContext {
  void dismissKeyboard() => FocusScope.of(this).unfocus();
}
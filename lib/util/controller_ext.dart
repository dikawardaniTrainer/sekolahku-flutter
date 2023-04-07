import 'package:flutter/material.dart';

extension ControllerExt on TextEditingController {
  void clear() {
    value = const TextEditingValue();
  }
}

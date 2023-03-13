// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

extension StateFulWidgetExt on State {
  void refresh([VoidCallback? callback]) {
    setState(() {
      callback?.call();
    });
  }
}

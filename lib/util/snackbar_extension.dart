import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';

extension SnackbarExt on BuildContext {

  void _showSnackBar(String message, Color bgColor, Color textColor){
    SnackBar snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: bgColor,
      content: Text(
          message,
          style: TextStyle(color: textColor)
      ),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  void showSuccessSnackBar(String message) {
    _showSnackBar(message, ColorRes.teal, ColorRes.white);
  }

  void showErrorSnackBar(String message) {
    _showSnackBar(message, ColorRes.red, ColorRes.white);
  }
}
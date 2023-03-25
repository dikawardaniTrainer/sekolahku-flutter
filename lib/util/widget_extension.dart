import 'package:flutter/material.dart';
import 'package:sekolah_ku/constant/student_const.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/util/logger.dart';
import 'package:sekolah_ku/util/navigation_extension.dart';
import 'package:sekolah_ku/widgets/confirmation_dialog.dart';
import 'package:sekolah_ku/widgets/loading_dialog.dart';

typedef OnGetResult<T> = Function(T result);
typedef OnGetError = Function(Object error, Object stackTrace);


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

extension DialogExt on BuildContext {

  void showConfirmationDialog({
    required String title,
    required String message,
    VoidCallback? onConfirmed,
    bool cancelAble = true,
    VoidCallback? onCancel
  }) async {
    await showDialog(
      context: this,
      barrierDismissible: cancelAble,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: title,
          message: message,
          onConfirmed: onConfirmed,
          onCancel: onCancel,
        );
      },
    );
  }

  void showLoadingDialog<T>({
    required String message,
    required Future<T> future,
    required OnGetResult<T> onGetResult,
    required OnGetError onGetError
  }) async {
    showDialog(
        context: this,
        barrierDismissible: false,
        builder: (context) => LoadingDialog(message: message)
    );
    if (useDummyLoading) await Future.delayed(const Duration(seconds: 5));
    try {
      final result = await future;
      goBack();
      onGetResult.call(result);
    } catch(e, s) {
      debugError(e, s);
      goBack();
      onGetError.call(e, s);
    }
  }
}
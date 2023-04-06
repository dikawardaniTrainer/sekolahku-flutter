import 'package:flutter/material.dart';
import 'package:sekolah_ku/constant/app_const.dart';
import 'package:sekolah_ku/util/logger.dart';
import 'package:sekolah_ku/util/navigation_extension.dart';
import 'package:sekolah_ku/widgets/confirmation_dialog.dart';
import 'package:sekolah_ku/widgets/loading_dialog.dart';

typedef OnGetResult<T> = Function(T result);
typedef OnGetError = Function(Object error, Object stackTrace);

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

  Future<DateTime?> showDatePickerDialog({
    required DateTime initial,
    required DateTime limitFirstDate,
    required DateTime limitLastDate
  }) async => await showDatePicker(
      context: this,
      initialDate: initial,
      firstDate: limitFirstDate,
      lastDate: limitLastDate
  );

  Future<DateTime?> showDatePickerDialogWithInitial(DateTime initial) async =>
      await showDatePickerDialog(
        initial: initial,
        limitFirstDate: DateTime(1945),
        limitLastDate: DateTime.now()
      );

  Future<T?> showBottomSheetDialog<T>(Widget content, {bool isScrollControlled = true}) {
    return showModalBottomSheet<T>(
        context: this,
        isScrollControlled: isScrollControlled,
        builder: (context) => Scrollable(viewportBuilder: (context, offset) => content)
    );
  }
}
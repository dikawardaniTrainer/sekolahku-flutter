
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';

extension ViewExt on BuildContext {
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

  showConfirmationDialog(String title, String message, VoidCallback? onConfirmed) {
    AlertDialog alert = AlertDialog(
      title: Column(
        children: [
          Row(
            children: [
              const Icon(IconRes.education, color: ColorRes.teal, size: DimenRes.size_40),
              const SizedBox(width: DimenRes.size_10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: ColorRes.teal)),
            ],
          ),
          const SizedBox(height: DimenRes.size_6,),
          const Divider(height: DimenRes.size_1, color: ColorRes.teal)
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
          child: const Text(StringRes.ok),
          onPressed: () {
            goBack();
            onConfirmed?.call();
          },
        ),
        TextButton(
          child: const Text(StringRes.cancel),
          onPressed: () { goBack(); },
        )
      ],
    );

    // show the dialog
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}

extension ContextExt on BuildContext {

  PageRoute<dynamic> createRoute(
     Widget destination,
     { bool isScreenDialog = false}
  ) {
   return MaterialPageRoute(
       fullscreenDialog: isScreenDialog,
       builder: (BuildContext context) => destination
   );
  }

  Future<dynamic> goToPage(
      Widget destination,
      { bool isRootPage = false, bool isScreenDialog = false}
  ) {
    final route = createRoute(destination, isScreenDialog: isScreenDialog);
    if (isRootPage) {
      return Navigator.pushReplacement(this, route);
    }
    return Navigator.push(this, route);
  }

  Future<dynamic> goToPageWithRouteName(
      String routeName,
      Object? argument,
      {bool isRootPage = false}
  ) {
    if (isRootPage) return Navigator.pushReplacementNamed(this, routeName, arguments: argument);
    return Navigator.pushNamed(this, routeName, arguments: argument);
  }

  void goBack<T extends Object?>([ T? result ]) {
    Navigator.pop(this, result);
  }

  void openLink(String link) {
    if (link.isEmpty) return;
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
          action: 'action_view',
          data: link
      );
      intent.launch();
      return;
    }

    showErrorSnackBar(StringRes.errOpenMapsNotSupported);
  }
}

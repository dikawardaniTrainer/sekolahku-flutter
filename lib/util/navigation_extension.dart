
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/util/widget_extension.dart';

extension NavigationExt on BuildContext {

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

  void goBackToFirstPage() {
    Navigator.popUntil(this, (route) => route.isFirst);
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

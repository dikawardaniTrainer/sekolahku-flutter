import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/util/navigation_extension.dart';

class IconBackButton extends StatelessWidget {
  final Color? iconColor;

  const IconBackButton({
    super.key,
    this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(IconRes.arrowBack, color: iconColor),
      onPressed: () { context.goBack(); },
    );
  }
}
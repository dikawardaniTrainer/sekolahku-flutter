import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';

class LoadingDialog extends StatelessWidget {
  final String message;
  final Color messageColor;
  final Color backgroundColor;
  final double backgroundOpacity;

  const LoadingDialog({
    super.key,
    this.message = StringRes.emptyString,
    this.messageColor = ColorRes.black,
    this.backgroundColor = ColorRes.transparent,
    this.backgroundOpacity = 0
  });

  Widget _createMessageWidget(String message) {
    return Column(
      children: [
        const SizedBox(height: DimenRes.size_16),
        Text(message, style: TextStyle(color: messageColor))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: backgroundOpacity,
          child: ModalBarrier(dismissible: false, color: backgroundColor),
        ),
        Center(
          child: SizedBox(
            height: DimenRes.size_150,
            child: Column(
              children: [
                const CircularProgressIndicator(),
                if (message.isNotEmpty) _createMessageWidget(message)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
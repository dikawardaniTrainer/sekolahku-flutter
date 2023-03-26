import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/util/navigation_extension.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title, message;
  final VoidCallback? onConfirmed, onCancel;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.onConfirmed,
    this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(DimenRes.size_16))),
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
            context.goBack();
            onConfirmed?.call();
          },
        ),
        TextButton(
          child: const Text(StringRes.cancel),
          onPressed: () {
            context.goBack();
            onCancel?.call();
          },
        )
      ],
    );
  }


}
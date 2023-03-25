import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';

class LoadingDialog extends StatelessWidget {
  final String message;

  const LoadingDialog({
    super.key,
    this.message = StringRes.emptyString
  });

  Widget _createMessageWidget(String message) {
    return Column(
      children: [
        const SizedBox(height: DimenRes.size_16),
        Text(message, maxLines: 3, textAlign: TextAlign.center)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Opacity(
          opacity: 0.3,
          child: ModalBarrier(dismissible: false, color: ColorRes.black),
        ),
        Center(
          child: SizedBox(
            width: DimenRes.size_400,
            height: DimenRes.size_150,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ColorRes.white,
                borderRadius: BorderRadius.all(Radius.circular(DimenRes.size_16))
              ),
              child: Padding(
                padding: const EdgeInsets.all(DimenRes.size_16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    if (message.isNotEmpty) _createMessageWidget(message)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
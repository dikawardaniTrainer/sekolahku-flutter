import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';

class Loading extends StatelessWidget {
  final String message;

  const Loading({
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
    return Padding(
      padding: const EdgeInsets.all(DimenRes.size_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (message.isNotEmpty) _createMessageWidget(message)
        ],
      ),
    );
  }
}

class LoadingBlocker extends StatelessWidget {
  final String message;
  final Widget? toBlock;

  const LoadingBlocker({
    super.key,
    this.message = StringRes.emptyString,
    this.toBlock
  });

  Widget get _background => const Opacity(
    opacity: 0.4,
    child: ModalBarrier(dismissible: false, color: ColorRes.black),
  );

  Widget get _blockerDialog => Center(
    child: SizedBox(
      width: DimenRes.size_400,
      height: DimenRes.size_150,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: const BorderRadius.all(Radius.circular(DimenRes.size_16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 10,
                blurRadius: 14,
                offset: const Offset(0, 10), // changes position of shadow
              )
            ]
        ),
        child: Loading(message: message),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final content = toBlock;
    return Material(
      child: Stack(
        children: [
          if (content != null) content,
          _background,
          _blockerDialog
        ],
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  final String message;

  const LoadingDialog({
    super.key,
    required this.message
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(DimenRes.size_16))),
      child: SizedBox(
        width: DimenRes.size_400,
        height: DimenRes.size_150,
        child: Loading(message: message),
      ),
    );
  }
}
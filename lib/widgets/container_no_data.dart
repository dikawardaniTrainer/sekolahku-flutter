import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/widgets/button.dart';

class ContainerNoData extends StatelessWidget {
  final String message;
  final VoidCallback? onRefreshClicked;

  const ContainerNoData({
    super.key,
    required this.message,
    this.onRefreshClicked
  });

  Widget _createRetryContainer() {
    return Column(
      children: [
        const SizedBox(height: DimenRes.size_8,),
        Button(label: StringRes.retry, isExpanded: false, onPressed: onRefreshClicked!)
      ],
    )  ;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(IconRes.noData, color: ColorRes.teal, size: DimenRes.size_100),
              const SizedBox(height: DimenRes.size_16),
              const Text(StringRes.notFound, style: TextStyle(
                  fontSize: DimenRes.size_18,
                  fontWeight: FontWeight.bold,
                  color: ColorRes.teal
              )),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
              if (onRefreshClicked != null) _createRetryContainer()
            ],
          ),
        )
      ],
    );
  }

}
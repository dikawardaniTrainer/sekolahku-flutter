import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';

class ContainerNoData extends StatelessWidget {
  final String message;

  const ContainerNoData({
    super.key,
    required this.message
  });

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
              )
            ],
          ),
        )
      ],
    );
  }

}
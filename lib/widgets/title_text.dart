import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';

import '../resources/color_res.dart';

class TitleText extends StatelessWidget {
  final String label;
  final double marginTop;
  final Color color;

  const TitleText({
    super.key,
    required this.label,
    this.marginTop = DimenRes.size_0,
    this.color = ColorRes.black
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (marginTop > DimenRes.size_0) SizedBox(height: marginTop),
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: DimenRes.size_22, color: color),
        )
      ],
    );
  }
}

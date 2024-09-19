import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';

import '../resources/color_res.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double marginTop;
  final bool isExpanded;
  final bool enabled;
  final Color? backgroundColor;
  final Color? textColor;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.marginTop = DimenRes.size_0,
    this.isExpanded = true,
    this.enabled = true,
    this.backgroundColor = ColorRes.tealMat,
    this.textColor = ColorRes.white
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = isExpanded ? const Size(double.infinity, DimenRes.size_60) : null;
    return Column(
      children: [
        if (marginTop > DimenRes.size_0) SizedBox(height: marginTop),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: buttonSize,
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DimenRes.size_16))),
          onPressed: enabled ? onPressed : null,
          child: Text(
            label,
            style: TextStyle(
                fontSize: DimenRes.size_16,
                fontWeight: FontWeight.bold,
                color: textColor
            ),
          ),
        )
      ],
    );
  }
}

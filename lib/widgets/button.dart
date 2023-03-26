import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double marginTop;
  final bool isExpanded;
  final bool enabled;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.marginTop = DimenRes.size_0,
    this.isExpanded = true,
    this.enabled = true
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DimenRes.size_16))),
          onPressed: enabled ? onPressed : null,
          child: Text(
            label,
            style: const TextStyle(fontSize: DimenRes.size_16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

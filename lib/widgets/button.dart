import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double marginTop;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.marginTop = DimenRes.size_0
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (marginTop > DimenRes.size_0) SizedBox(height: marginTop),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, DimenRes.size_60),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DimenRes.size_16))),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(fontSize: DimenRes.size_16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';

class TitlePopMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;

  const TitlePopMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: DimenRes.size_8),
              Text(title)
            ]
        ),
        const SizedBox(height: DimenRes.size_10),
        const Divider(height: DimenRes.size_1, color: Colors.teal)
      ],
    );
  }
}
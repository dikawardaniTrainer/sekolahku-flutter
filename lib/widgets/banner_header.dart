import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/widgets/title_text.dart';

class BannerHeader extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final String title;
  final double height;
  final Color? bgColor;

  const BannerHeader({
    super.key,
    required this.iconData,
    this.title = "",
    this.height = DimenRes.size_250,
    this.iconSize = DimenRes.size_100,
    this.iconColor = ColorRes.white,
    this.bgColor
  });

  @override
  Widget build(BuildContext context) {
    var activeBgColor = ColorRes.teal;
    final toSetBgColor = bgColor;
    if (toSetBgColor != null) {
      activeBgColor = toSetBgColor;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: height,
          color: activeBgColor,
        ),
        Center(
          child: Column(
            children: [
              Icon(iconData, size: iconSize, color: iconColor),
              if (title.isNotEmpty) const SizedBox(height: DimenRes.size_6),
              if (title.isNotEmpty) TitleText(label: title, marginTop: DimenRes.size_16, color: ColorRes.white),
            ],
          ),
        )
      ],
    );
  }
}

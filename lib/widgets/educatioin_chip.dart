import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/util/widget_extension.dart';

import '../constant/student_const.dart';

class EducationChip extends StatelessWidget {
  final String education;

  const EducationChip({
    super.key,
    required this.education
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = ColorRes.grey;
    if (education == educationOptions[1]) bgColor = ColorRes.red;
    if (education == educationOptions[2]) bgColor = ColorRes.blueDark;
    if (education == educationOptions[3]) bgColor = ColorRes.greyDark;
    if (education == educationOptions[4]) bgColor = ColorRes.green;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(DimenRes.size_8)
      ),
      child: Padding(
        padding: Spaces.verticalAndHorizontal(horizontal: DimenRes.size_10, vertical: DimenRes.size_4),
        child: Text(
          education,
          style: const TextStyle(color: ColorRes.white, fontSize: DimenRes.size_12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
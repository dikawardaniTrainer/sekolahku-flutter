import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sekolah_ku/model/student.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/widgets/educatioin_chip.dart';
import 'package:sekolah_ku/widgets/pop_up_menu.dart';

typedef OnActionSelected = void Function(String action, Student student);

class ItemSynopsisStudent extends StatelessWidget {
  final Student student;
  final GestureTapCallback? onTap;
  final OnActionSelected? onActionSelected;

  const ItemSynopsisStudent({
    super.key,
    required this.student,
    this.onTap,
    this.onActionSelected
  });

  Widget _createContainer() {
    Color genderColor;
    IconData genderIcon;
    if (student.gender == StringRes.male) {
      genderColor = ColorRes.blue;
      genderIcon = IconRes.male;
    } else {
      genderColor = ColorRes.pink;
      genderIcon = IconRes.female;
    }
    return Padding(
      padding: const EdgeInsets.all(DimenRes.size_10),
      child: Row(
        children: [
          const Icon(IconRes.accountCircleOutline, size: DimenRes.size_60, color: ColorRes.teal),
          const SizedBox(width: DimenRes.size_8),
          Expanded(child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(
                      student.fullName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: DimenRes.size_18)
                  )),
                  const SizedBox(width: DimenRes.size_16),
                  EducationChip(education: student.education)
                ],
              ),
              const SizedBox(height: DimenRes.size_4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(student.phoneNumber),
                  Row(
                    children: [
                      Text(student.gender, style: TextStyle(color: genderColor)),
                      const SizedBox(width: DimenRes.size_4),
                      Icon(genderIcon, color: genderColor),
                    ],
                  )
                ],
              )
            ],
          )),
          PopUpMenu(
            onSelected: (s) {
              onActionSelected?.call(s, student);
            },
            menuItems: [
              MenuItemConfig(
                  title: StringRes.edit,
                  icon: IconRes.edit,
                  iconColor: ColorRes.teal
              ),
              MenuItemConfig(
                  title: StringRes.delete,
                  icon: IconRes.delete,
                  iconColor: ColorRes.red
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Slidable(
        key: super.key,
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) { onTap?.call(); },
              backgroundColor: ColorRes.teal,
              foregroundColor: Colors.white,
              icon: IconRes.info,
              label: StringRes.info,
            )
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) { onActionSelected?.call(StringRes.edit, student); },
              backgroundColor: ColorRes.teal,
              foregroundColor: Colors.white,
              icon: IconRes.edit,
              label: StringRes.edit,
            ),
            SlidableAction(
              onPressed: (context) { onActionSelected?.call(StringRes.delete, student); },
              backgroundColor: ColorRes.red,
              foregroundColor: Colors.white,
              icon: IconRes.delete,
              label: StringRes.delete,
            )
          ],
        ),
        child: _createContainer()
      ),
    );
  }
}
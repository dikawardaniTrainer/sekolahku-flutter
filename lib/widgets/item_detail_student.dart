import 'package:flutter/material.dart';
import 'package:sekolah_ku/model/student.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/util/date_extension.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';

typedef OnOpenLink = void Function(String value);

class ItemDetail {
  final IconData iconData;
  final String title;
  final String? value;
  final String? link;

  ItemDetail(this.iconData, this.title, this.value, {this.link = StringRes.emptyString});

  static List<ItemDetail> createListItemDetailFrom(Student? student) {
    final List<ItemDetail> itemDetails = [];

    itemDetails.add(ItemDetail(IconRes.name, StringRes.fullName, student?.fullName));
    itemDetails.add(ItemDetail(IconRes.phone, StringRes.phoneNumber, student?.phoneNumber));
    itemDetails.add(ItemDetail(IconRes.email, StringRes.email, student?.email));
    itemDetails.add(ItemDetail(IconRes.date, StringRes.birthDate, student?.birthDate?.format()));
    itemDetails.add(ItemDetail(IconRes.education, StringRes.education, student?.education));
    itemDetails.add(ItemDetail(IconRes.gender, StringRes.gender, student?.gender));
    itemDetails.add(ItemDetail(IconRes.hobbies, StringRes.hobbies, student?.hobbies.join(", ")));
    itemDetails.add(ItemDetail(IconRes.location, StringRes.address, student?.address, link: student?.gmapsLink));

    return itemDetails;
  }
}

class ItemDetailStudent extends StatelessWidget {
  final ItemDetail itemDetail;
  final OnOpenLink? onGMapLinkTapped;
  
  const ItemDetailStudent({
    super.key,
    required this.itemDetail,
    this.onGMapLinkTapped
  });
  
  @override
  Widget build(BuildContext context) {
    var valueToShow = StringRes.notRecorded;
    var valueStyles = const TextStyle(
      fontSize: DimenRes.size_16,
      color: ColorRes.grey,
      fontStyle: FontStyle.italic
    );

    final value = itemDetail.value;
    if (value != null && value.isNotEmpty) {
      valueToShow = value;
      valueStyles = const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: DimenRes.size_18,
          color: ColorRes.black
      );
    }

    final link = itemDetail.link;
    return Padding(
      padding: const EdgeInsets.all(DimenRes.size_10),
      child: Row(
        children: [
          Icon(itemDetail.iconData, size: DimenRes.size_40, color: ColorRes.teal),
          const SizedBox(width: DimenRes.size_20),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemDetail.title, style: const TextStyle(color: ColorRes.teal)),
              const SizedBox(height: DimenRes.size_4),
              Text(
                valueToShow,
                textAlign: TextAlign.justify,
                style: valueStyles,
                overflow: TextOverflow.clip,
              ),
              if (link != null && link.isNotEmpty) InkWell(
                onTap: () { onGMapLinkTapped?.call(link); },
                child: Text(link, style: const TextStyle(
                  color: Colors.blue,
                  fontStyle: FontStyle.italic,
                )),
              )
            ],
          ))
        ],
      ),
    );
  }

}
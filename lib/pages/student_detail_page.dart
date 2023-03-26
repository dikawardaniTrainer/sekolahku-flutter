import 'package:flutter/material.dart';
import 'package:sekolah_ku/model/student.dart';
import 'package:sekolah_ku/navigation/app_navigation.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/services/app_service.dart';
import 'package:sekolah_ku/util/navigation_extension.dart';
import 'package:sekolah_ku/util/state_extension.dart';
import 'package:sekolah_ku/widgets/banner_header.dart';
import 'package:sekolah_ku/widgets/custom_future_builder.dart';
import 'package:sekolah_ku/widgets/icon_back_button.dart';
import 'package:sekolah_ku/widgets/item_detail_student.dart';
import 'package:sekolah_ku/widgets/loading_dialog.dart';

class StudentDetailPage extends StatefulWidget {
  final int id;

  const StudentDetailPage({
    super.key,
    required this.id
  });

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  final _studentService = AppService.studentService;
  Student? currentStudent;

  void _startEditStudent() {
    final toEdit = currentStudent;
    if (toEdit != null) {
      context.startStudentFormPage(toEdit)
          .then((value) => refresh());
    }
  }

  Widget _createDetail(Student? student) {
    currentStudent = student;
    final items = ItemDetail.createListItemDetailFrom(currentStudent);

    return SingleChildScrollView(
      child: Column(
        children: [
          const BannerHeader(
            iconData: IconRes.accountCircleOutline,
            iconSize: DimenRes.size_100,
            iconColor: ColorRes.teal,
            height: DimenRes.size_150,
            bgColor: ColorRes.transparent,
          ),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: DimenRes.size_10, bottom: DimenRes.size_10),
              itemCount: items.length,
              separatorBuilder: (context, i) => const Divider(color: ColorRes.grey, height: DimenRes.size_1),
              itemBuilder: (context, i) {
                final itemDetail = items[i];
                return ItemDetailStudent(
                  itemDetail: itemDetail,
                  onGMapLinkTapped: (link) => context.openLink(link),
                );
              }
          )
        ],
      ),
    );
  }

  Widget _createPage(Student? student) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringRes.detailStudent),
        leading: const IconBackButton(),
      ),
      body: _createDetail(student),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          IconRes.edit,
          color: ColorRes.white,
        ),
        onPressed: () { _startEditStudent(); },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
        future: _studentService.findById(widget.id),
        onShowDataWidget: (data) => _createPage(data),
        noDataWidget: _createPage(null),
        loadingWidget: LoadingBlocker(
          message: StringRes.loadingDetailStudent,
          toBlock: _createPage(null),
        )
    );
  }
}
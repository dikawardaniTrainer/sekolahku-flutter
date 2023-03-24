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
import 'package:sekolah_ku/util/widget_extension.dart';
import 'package:sekolah_ku/widgets/banner_header.dart';
import 'package:sekolah_ku/widgets/custom_future_builder.dart';
import 'package:sekolah_ku/widgets/icon_back_button.dart';
import 'package:sekolah_ku/widgets/item_detail_student.dart';
import 'package:sekolah_ku/widgets/loading_dialog.dart';
import 'package:sprintf/sprintf.dart';

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

  Widget _createLoading() {
    return Stack(
      children: [
        _createDetail(null),
        const LoadingDialog(
          backgroundColor: ColorRes.black,
          backgroundOpacity: 0.3,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringRes.detailStudent),
        leading: const IconBackButton(),
      ),
      body: CustomFutureBuilder<Student?>(
          future: _studentService.findById(widget.id),
          loadingWidget: _createLoading(),
          noDataWidget: _createDetail(null),
          onErrorFuture: (e, s) => context.showErrorSnackBar(sprintf(StringRes.errorStudentIdNotFound, [widget.id.toString()])),
          onShowDataWidget: (data) => _createDetail(data),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          IconRes.edit,
          color: ColorRes.white,
        ),
        onPressed: () { _startEditStudent(); },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sekolah_ku/resources/color_res.dart';
import 'package:sekolah_ku/resources/dimen_res.dart';
import 'package:sekolah_ku/resources/icon_res.dart';
import 'package:sekolah_ku/resources/string_res.dart';
import 'package:sekolah_ku/util/navigation_extension.dart';
import 'package:sekolah_ku/widgets/button.dart';
import 'package:sekolah_ku/widgets/title_text.dart';

enum ResultType {
  success, failed
}

class ResultPage extends StatelessWidget {
  final String message;
  final ResultType type;
  final bool showGoBackHome;

  const ResultPage({
    super.key,
    required this.type,
    required this.message,
    this.showGoBackHome = false
  });

  IconData get _icon {
    switch(type) {
      case ResultType.success: return IconRes.success;
      case ResultType.failed: return IconRes.failed;
    }
  }

  Color get _backgroundColor {
    switch(type) {
      case ResultType.success: return ColorRes.green;
      case ResultType.failed: return ColorRes.red;
    }
  }

  String get _title {
    switch(type) {
      case ResultType.success: return StringRes.success;
      case ResultType.failed: return StringRes.failed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: _backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: DimenRes.size_30,),
            IconButton(onPressed: () => context.goBack(), icon: const Icon(IconRes.close, color: ColorRes.white,)),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(DimenRes.size_60),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_icon, color: ColorRes.white, size: DimenRes.size_60,),
                    const SizedBox(height: DimenRes.size_16,),
                    TitleText(label: _title, color: ColorRes.white,),
                    const SizedBox(height: DimenRes.size_10,),
                    Text(message, style: const TextStyle(color: ColorRes.white), textAlign: TextAlign.center,)
                  ],
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(DimenRes.size_16),
              child: Column(
                children: [
                  Button(label: StringRes.goBack, onPressed: () => context.goBack()),
                  if (showGoBackHome) Button(label: StringRes.goBackHome, marginTop: DimenRes.size_16, onPressed: () => context.goBackToFirstPage())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
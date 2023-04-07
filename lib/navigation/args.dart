import 'package:sekolah_ku/pages/result_page.dart';

class Args {
  final bool isScreenDialog;
  Object? data;

  Args({
    required this.isScreenDialog,
    this.data
  });
}

class ResultData {
  final String message;
  final ResultType type;
  final bool showGoBackHome;

  const ResultData(this.message, this.type, {this.showGoBackHome = false});
}
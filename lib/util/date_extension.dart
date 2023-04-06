import 'package:intl/intl.dart';
import 'package:sekolah_ku/constant/app_const.dart';

extension DateHelper on DateTime? {
  String format() {
    final toFormat = this;
    if (toFormat != null) {
      try {
        return DateFormat(datePattern).format(toFormat);
      } catch (e) {
        return "";
      }
    }
    return "";
  }
}

extension DateStringHelper on String {
  DateTime? parse() {
    final toParse = this;
    if (toParse.isEmpty) return null;
    try {
      return DateFormat(datePattern).parse(toParse);
    } catch(e) {
      return null;
    }
  }
}

import 'package:intl/intl.dart';

extension SeoDateFormatter on DateTime {
  String dayMonthYear() {
    try {
      return DateFormat("dd-MM-yyyy").format(DateTime.parse(toString()));
    } on Exception catch (e) {
      return toString();
    }
  }

  String yearMonthDay() {
    try {
      return DateFormat("yyyy-MM-dd").format(DateTime.parse(toString()));
    } on Exception catch (e) {
      return toString();
    }
  }
// ···
}
import 'package:intl/intl.dart';

class Formatter {
  static String capitalize(String value) {
    return "${value[0].toUpperCase()}${value.substring(1)}";
  }

  static String dateToString(DateTime v) {
    String day =
        "${v.year.toString()}/${v.month.toString()}/${v.day.toString()}";
    String time = "${v.hour.toString()}:${v.minute.toString()}";
    return "$day\n$time";
  }

  static String formatFundAmount(dynamic value) {
    final numberFormat = NumberFormat("#,##0.00", "en_US");
    return numberFormat.format(value);
  }

  static String strDigits(int n) => n.toString().padLeft(2, '0');

  static String? truncateWithEllipsis(int cutoff, String? value) {
    if (value == null) {
      return value;
    }

    return (value.length <= cutoff)
        ? value
        : '${value.substring(0, cutoff)}...';
  }
}

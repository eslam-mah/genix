import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExtension on DateTime {
  String format([String format = 'dd/mm/yy']) {
    return DateFormat(format).format(this);
  }

  String toTimeAgo() {
    return timeago.format(this);
  }
}

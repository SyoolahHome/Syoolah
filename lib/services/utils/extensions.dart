import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExt on DateTime {
  String toReadableString() {
    return timeago.format(this);
  }
}

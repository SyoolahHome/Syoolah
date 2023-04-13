import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExt on DateTime {
  String toReadableString() {
    return timeago.format(
      this,
      allowFromNow: true,
    );
  }

  String memberForTime() {
    final duration = Duration(
      seconds: DateTime.now().difference(this).inSeconds,
    );
    final years = duration.inDays ~/ 365;
    final months = duration.inDays ~/ 30;
    final days = duration.inDays;
    final hours = duration.inHours;
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds;

    String memebership = '';

    if (years > 0) {
      memebership = '$years years';
    } else if (months > 0) {
      memebership = '$months months';
    } else if (days > 0) {
      memebership = '$days days';
    } else if (hours > 0) {
      memebership = '$hours hours';
    } else if (minutes > 0) {
      memebership = '$minutes minutes';
    } else if (seconds > 0) {
      memebership = '$seconds seconds';
    }

    return 'Member for $memebership';
  }

  String get formatted {
    return '${this.day}/${this.month}/${this.year}';
  }
}

// extension for capitalize().

extension StringExt on String {
  String get capitalized => '${this[0].toUpperCase()}${this.substring(1)}';
}

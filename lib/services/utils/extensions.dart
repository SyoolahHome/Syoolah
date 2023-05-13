import 'package:dart_nostr/dart_nostr.dart';
import 'package:timeago/timeago.dart' as timeago;

extension Extensions on List<NostrEvent> {
  List<NostrEvent> removeDuplicatedEvents() {
    final List<NostrEvent> result = [];

    for (final event in this) {
      if (result.isEmpty) {
        result.add(event);
      } else {
        final isDuplicated = result.any(
          (element) {
            return element.pubkey == event.pubkey;
          },
        );
        if (!isDuplicated) {
          result.add(event);
        }
      }
    }

    return result;
  }
}

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
    return '$day/$month/$year';
  }
}

extension StringExt on String {
  String get capitalized {
    if (isEmpty) {
      return this;
    } else if (length == 1) {
      return toUpperCase();
    } else {
      return '${this[0].toUpperCase()}${substring(1)}';
    }
  }

  bool get isValidWebSocketSchema {
    if (!startsWith("ws://") && !startsWith("wss://")) {
      return false;
    }

    if (!contains("/")) {
      return false;
    }

    if (contains(" ")) {
      return false;
    }

    RegExp regex = RegExp(
      r"^[a-zA-Z0-9\-\.\_\~\:\/\?\#\[\]\@\!\$\&\'\(\)\*\+\,\;\=]+$",
    );

    if (!regex.hasMatch(this)) {
      return false;
    }

    return true;
  }
}

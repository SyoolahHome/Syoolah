import 'package:dart_nostr/dart_nostr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../database/local/local_database.dart';

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

  List<NostrEvent> excludeCommentEvents() {
    return where((noteEvent) {
      final noteEventTags = noteEvent.tags;

      return noteEventTags.any((tagList) {
        final isNotComment = tagList.first != "e";

        return isNotComment;
      });
    }).toList();
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
      memebership = "nYears".tr(args: ["$years"]);
    } else if (months > 0) {
      memebership = "nMonths".tr(args: ["$months"]);
    } else if (days > 0) {
      memebership = "nDays".tr(args: ["$days"]);
    } else if (hours > 0) {
      memebership = "nHours".tr(args: ["$hours"]);
    } else if (minutes > 0) {
      memebership = "nMinutes".tr(args: ["$minutes"]);
    } else if (seconds > 0) {
      memebership = "nSeconds".tr(args: ["$seconds"]);
    }

    return 'Last updated $memebership ago';
  }

  String get formatted {
    return '$day/$month/$year';
  }
}

extension StringExt on String {
  String get titleCapitalized {
    // capitalize all words in title.
    final List<String> words = split(" ");
    final List<String> capitalizedWords = [];

    for (final word in words) {
      capitalizedWords.add(word.capitalized);
    }

    return capitalizedWords.join(" ");
  }

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

extension ScrollControllerExt on ScrollController {
  bool get isNotAtBottom {
    if (hasClients) {
      return false;
    }

    final maxScroll = position.maxScrollExtent;
    final currentScroll = position.pixels;

    return maxScroll - currentScroll > 100;
  }

  Future<void> animateToBottom() async {
    if (isNotAtBottom && hasClients) {
      return animateTo(
        position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}

extension StreamExtensions<T> on Stream<T> {
  Stream<T> intervalDuration(Duration delay) async* {
    await for (final val in this) {
      yield val;
      await Future.delayed(delay);
    }
  }
}

extension ColorExtension on Color {
  String toHex() {
    return '#${value.toRadixString(16).substring(2, 8)}';
  }
}

extension ThemeModeExtension on ThemeMode {
  ThemeMode decideBasedOnLocaleThemeStatusButDefaultToSystemOnFirstTime() {
    final themeStateFromLocal = LocalDatabase.instance.getThemeState();

    if (themeStateFromLocal != null) {
      return themeStateFromLocal ? ThemeMode.dark : ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }
}

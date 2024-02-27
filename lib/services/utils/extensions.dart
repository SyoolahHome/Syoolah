import 'dart:io';

import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/model/bottom_sheet_option.dart';
import 'package:ditto/model/relay_configuration.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constants/app_enums.dart';
import '../../model/feed_category.dart';
import '../../model/loclal_item.dart';
import '../../model/note.dart';
import '../database/local/local_database.dart';

extension NostrEventqListExtensions on List<NostrEvent> {
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

extension NotesListExtension on List<Note> {
  List<Note> excludeCommentNotes() {
    return where((note) {
      final noteEventTags = note.event.tags;

      return noteEventTags.any((tagList) {
        final isNotComment = tagList.first != "e";

        return isNotComment;
      });
    }).toList();
  }

  List<Note> onlyCommentNotes() {
    return where((note) {
      final noteEventTags = note.event.tags;

      return noteEventTags.any((tagList) {
        final isComment = tagList.first == "e";

        return isComment;
      });
    }).toList();
  }
}

extension DateTimeExt on DateTime {
  String toReadableString(String locale) {
    return timeago.format(
      this,
      locale: locale,
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
      memebership = years > 1
          ? "nYears".tr(args: ["$years"])
          : "nYear".tr(args: ["$years"]);
    } else if (months > 0) {
      memebership = months > 1
          ? "nMonths".tr(args: ["$months"])
          : "nMonth".tr(args: ["$months"]);
    } else if (days > 0) {
      memebership =
          days > 1 ? "nDays".tr(args: ["$days"]) : "nDay".tr(args: ["$days"]);
    } else if (hours > 0) {
      memebership = hours > 1
          ? "nHours".tr(args: ["$hours"])
          : "nHour".tr(args: ["$hours"]);
    } else if (minutes > 0) {
      memebership = minutes > 1
          ? "nMinutes".tr(args: ["$minutes"])
          : "nMinute".tr(args: ["$minutes"]);
    } else if (seconds > 0) {
      memebership = seconds > 1
          ? "nSeconds".tr(args: ["$seconds"])
          : "nSecond".tr(args: ["$seconds"]);
    }

    return 'last_updated'.tr(args: [memebership]);
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
      return ThemeMode.dark;
    }
  }
}

extension FeedCategoryListExtension on Iterable<FeedCategory> {
  Iterable<FeedCategory> get whereSelected => where((e) => e.isSelected);
  List<List<String>> toNostrTagsList() =>
      map((e) => ["t", e.enumValue.alIttihadName]).toList();
}

extension XFileListExtension on List<XFile> {
  List<File> toListOfFiles() => map((xf) => File(xf.path)).toList();
}

extension RelayConfigurationListExtension on List<RelayConfiguration> {
  List<String> toListOfUrls() => map((e) => e.url).toList();

  List<RelayConfiguration> without(RelayConfiguration relay) =>
      where((element) {
        final isTheTargetRelayToRemove = element.url == relay.url;

        return !isTheTargetRelayToRemove;
      }).toList();

  List<String> activeUrls() {
    return where((relay) => relay.isActive).map((relay) => relay.url).toList();
  }
}

extension LocalItemListExtension on List<LocaleItem> {
  List<BottomSheetOption> toBottomSheetTranslationOptions(
    BuildContext context, {
    required void Function(LocaleItem localItem) onEachTap,
  }) {
    return map(
      (localeItem) {
        return BottomSheetOption.translationOption(
          localeItem: localeItem,
          onTap: () => onEachTap(localeItem),
          isCurrentApplied: context.locale == localeItem.locale,
        );
      },
    ).toList();
  }
}

extension BuildContextExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

extension FlutterRemixExtension on FlutterRemix {
  static IconData directionality_arrow_left_fill(BuildContext context) {
    return context.locale.countryCode?.toLowerCase() == "ar"
        ? FlutterRemix.arrow_right_fill
        : FlutterRemix.arrow_left_fill;
  }

  static IconData directionality_arrow_left_line(BuildContext context) {
    return context.locale.countryCode?.toLowerCase() == "ar"
        ? FlutterRemix.arrow_right_line
        : FlutterRemix.arrow_left_line;
  }
}

extension NostrEventExtension on NostrEvent? {
  List<String>? get tagsPublicKeys {
    return this
        ?.tags
        .where((tag) => tag[0] == "p")
        .map((tag) => tag[1])
        .toList();
  }
}

extension AlIttihadTopicsExt on AlIttihadTopics {
  String get alIttihadName => "alIttihad_app$name";
}

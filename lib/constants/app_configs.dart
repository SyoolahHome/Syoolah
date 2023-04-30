import 'package:ditto/constants/app_strings.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import '../model/feed_category.dart';
import '../model/search_option.dart';

abstract class AppConfigs {
  static const relaysUrls = [
    'wss://eden.nostr.land',
    'wss://nostr.fmt.wiz.biz',
    'wss://relay.damus.io',
    'wss://nostr-pub.wellorder.net',
    'wss://relay.nostr.info',
    'wss://offchain.pub',
    'wss://nos.lol',
    'wss://brb.io',
    'wss://relay.snort.social',
    'wss://relay.current.fyi',
    'wss://nostr.relayer.se',
  ];
  static final List<FeedCategory> categories = [
    const FeedCategory(
      name: AppStrings.quran,
      description: "This feed contains Quran",
      icon: FlutterIslamicIcons.quran,
      isSelected: false,
      path: Paths.quranFeed,
    ),
    const FeedCategory(
      name: AppStrings.dua,
      description: "This feed contains Quran",
      icon: FlutterIslamicIcons.prayer,
      isSelected: false,
      path: Paths.duaFeed,
    ),
    const FeedCategory(
      name: AppStrings.sharia,
      description: "This feed contains Quran",
      icon: FlutterIslamicIcons.kowtow,
      isSelected: false,
      path: Paths.shariaFeed,
    ),
    const FeedCategory(
      name: AppStrings.hadith,
      description: "This feed contains Quran",
      icon: FlutterIslamicIcons.sajadah,
      isSelected: false,
      path: Paths.hadithFeed,
    ),
    const FeedCategory(
      name: AppStrings.fiqh,
      description: "This feed contains Quran",
      icon: FlutterIslamicIcons.family,
      isSelected: false,
      path: Paths.fiqhFeed,
    ),
    const FeedCategory(
      name: AppStrings.sirah,
      description: "This feed contains Quran",
      icon: FlutterIslamicIcons.solidMuslim,
      isSelected: false,
      path: Paths.sirahFeed,
    ),
  ];

  static final feedsSearchOptions = [
    SearchOption(
      name: "Search usernames",
      isSelected: false,
      searchFunction: (noteList, string) => noteList
          .where((note) =>
              note.event.pubkey.toLowerCase().contains(string.toLowerCase()))
          .toList(),
      useSearchQuery: true,
    ),
    SearchOption(
      name: 'Search Posts contents',
      isSelected: false,
      searchFunction: (noteList, string) => noteList
          .where((note) =>
              note.event.content.toLowerCase().contains(string.toLowerCase()))
          .toList(),
      useSearchQuery: true,
    ),
    SearchOption(
      name: 'Search Posts dates',
      isSelected: false,
      searchFunction: (noteList, string) => noteList
          .where((note) =>
              note.event.createdAt.toString().contains(string) ||
              note.event.createdAt.millisecondsSinceEpoch
                  .toString()
                  .contains(string))
          .toList(),
      useSearchQuery: true,
    ),
    SearchOption(
      name: 'Search hashtags',
      isSelected: false,
      searchFunction: (noteList, string) => noteList
          .where((note) => note.event.content
              .toLowerCase()
              .contains('#$string'.toLowerCase()))
          .toList(),
      useSearchQuery: true,
    ),
    SearchOption(
      name: 'Only posts with images',
      isSelected: false,
      searchFunction: (noteList, string) =>
          noteList.where((note) => note.imageLinks.isNotEmpty).toList(),
      useSearchQuery: false,
    ),
  ];
}

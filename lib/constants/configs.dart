import 'package:ditto/constants/strings.dart';
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
    // 'wss://relay.nostr.info',
    'wss://offchain.pub',
    'wss://nos.lol',
    // 'wss://brb.io', // throws error
    'wss://relay.snort.social',
    'wss://relay.current.fyi',
    'wss://nostr.relayer.se',
  ];
  static final List<FeedCategory> categories = [
    const FeedCategory(
      path: Paths.quranFeed,
      icon: FlutterIslamicIcons.quran,
      isSelected: false,
      name: AppStrings.quran,
      description: "This feed contains Quran",
    ),
    const FeedCategory(
      path: Paths.duaFeed,
      icon: FlutterIslamicIcons.prayer,
      isSelected: false,
      name: AppStrings.dua,
      description: "This feed contains Quran",
    ),
    const FeedCategory(
      path: Paths.shariaFeed,
      icon: FlutterIslamicIcons.kowtow,
      isSelected: false,
      name: AppStrings.sharia,
      description: "This feed contains Quran",
    ),
    const FeedCategory(
      path: Paths.hadithFeed,
      icon: FlutterIslamicIcons.sajadah,
      isSelected: false,
      name: AppStrings.hadith,
      description: "This feed contains Quran",
    ),
    const FeedCategory(
      path: Paths.fiqhFeed,
      icon: FlutterIslamicIcons.family,
      isSelected: false,
      name: AppStrings.fiqh,
      description: "This feed contains Quran",
    ),
    const FeedCategory(
      path: Paths.sirahFeed,
      icon: FlutterIslamicIcons.solidMuslim,
      isSelected: false,
      name: AppStrings.sirah,
      description: "This feed contains Quran",
    ),
  ];

  static final feedsSearchOptions = [
    SearchOption(
      name: "Search usernames",
      isSelected: false,
      useSearchQuery: true,
      searchFunction: (noteList, string) => noteList
          .where(
            (note) =>
                note.event.pubkey.toLowerCase().contains(string.toLowerCase()),
          )
          .toList(),
    ),
    SearchOption(
      name: 'Search Posts contents',
      isSelected: false,
      useSearchQuery: true,
      searchFunction: (noteList, string) => noteList
          .where(
            (note) =>
                note.event.content.toLowerCase().contains(string.toLowerCase()),
          )
          .toList(),
    ),
    SearchOption(
      name: 'Search Posts dates',
      isSelected: false,
      useSearchQuery: true,
      searchFunction: (noteList, string) => noteList
          .where(
            (note) =>
                note.event.createdAt.toString().contains(string) ||
                note.event.createdAt.millisecondsSinceEpoch
                    .toString()
                    .contains(string),
          )
          .toList(),
    ),
    SearchOption(
      name: 'Search hashtags',
      useSearchQuery: true,
      isSelected: false,
      searchFunction: (noteList, string) => noteList
          .where(
            (note) => note.event.content
                .toLowerCase()
                .contains('#$string'.toLowerCase()),
          )
          .toList(),
    ),
    SearchOption(
      name: 'Only posts with images',
      isSelected: false,
      useSearchQuery: false,
      searchFunction: (noteList, string) => noteList
          .where(
            (note) => note.imageLinks.isNotEmpty,
          )
          .toList(),
    ),
  ];
}

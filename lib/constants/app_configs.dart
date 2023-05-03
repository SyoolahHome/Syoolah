import 'package:ditto/constants/app_strings.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_remix/flutter_remix.dart';
import '../buisness_logic/app/app_cubit.dart';
import '../buisness_logic/cubit/settings_cubit.dart';
import '../model/feed_category.dart';
import '../model/search_option.dart';
import '../model/settings_item.dart';
import '../presentation/navigations_screen/home/widgets/relays_widget.dart';
import '../services/utils/routing.dart';

abstract class AppConfigs {
  static const relaysUrls = [
    'wss://eden.nostr.land',
    'wss://nostr.fmt.wiz.biz',
    'wss://relay.damus.io',
    'wss://nostr-pub.wellorder.net',
    // 'wss://relay.nostr.info',
    'wss://offchain.pub',
    'wss://nos.lol',
    // 'wss://brb.io',
    'wss://relay.snort.social',
    'wss://relay.current.fyi',
    // 'wss://nostr.relayer.se',
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

  static List<SettingsItem> settings(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return <SettingsItem>[
      SettingsItem(
        icon: FlutterRemix.cloud_line,
        name: AppStrings.relaysConfigs,
        onTap: () {
          Navigator.of(context).pushNamed(Paths.relaysConfig);
        },
        trailing: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.3),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  state.relaysConfigurations
                      .map((e) => e.isActive)
                      .length
                      .toString(),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      // color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
            );
          },
        ),
      ),
      SettingsItem(
        icon: FlutterRemix.moon_line,
        name: AppStrings.switchDarkMode,
        onTap: () {
          cubit.switchDarkMode();
        },
        trailing: Transform.scale(
          alignment: Alignment.centerRight,
          scale: .75,
          child: Switch(
            value: LocalDatabase.instance.getThemeState(),
            onChanged: (value) {
              cubit.switchDarkMode();
            },
          ),
        ),
      ),
      SettingsItem(
        icon: FlutterRemix.key_line,
        name: AppStrings.myKeys,
        onTap: () {
          Navigator.of(context).pushNamed(Paths.myKeys);
        },
      ),
      SettingsItem(
        icon: FlutterRemix.translate,
        name: AppStrings.changeLanguage,
        onTap: () {
          Routing.appCubit.showTranslationsSheet(context);
        },
      ),
      SettingsItem(
        icon: FlutterRemix.logout_box_line,
        name: AppStrings.logout,
        onTap: () {
          cubit.logout();
        },
      ),
    ];
  }
}

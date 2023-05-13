import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_remix/flutter_remix.dart';
import '../buisness_logic/app/app_cubit.dart';
import '../buisness_logic/cubit/settings_cubit.dart';
import '../model/feed_category.dart';
import '../model/loclal_item.dart';
import '../model/search_option.dart';
import '../model/settings_item.dart';
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
    FeedCategory(
      name: "quran".tr(),
      description: "This feed contains Quran",
      icon: FlutterIslamicIcons.quran,
      isSelected: false,
      path: Paths.quranFeed,
    ),
    FeedCategory(
      name: "dua".tr(),
      description: "This feed contains Quran",
      icon: FlutterIslamicIcons.prayer,
      isSelected: false,
      path: Paths.duaFeed,
    ),
    FeedCategory(
      name: "sharia".tr(),
      description: "This feed contains Quran",
      icon: FlutterIslamicIcons.kowtow,
      isSelected: false,
      path: Paths.shariaFeed,
    ),
    FeedCategory(
      name: "hadith".tr(),
      description: "This feed contains Quran",
      icon: FlutterIslamicIcons.sajadah,
      isSelected: false,
      path: Paths.hadithFeed,
    ),
    FeedCategory(
      name: "fiqh".tr(),
      description: "This feed contains Quran",
      icon: FlutterIslamicIcons.family,
      isSelected: false,
      path: Paths.fiqhFeed,
    ),
    FeedCategory(
      name: "sirah".tr(),
      description: "This feed contains Quran",
      icon: FlutterIslamicIcons.solidMuslim,
      isSelected: false,
      path: Paths.sirahFeed,
    ),
  ];

  static final localeItems = <LocaleItem>[
    LocaleItem(
      applyText: "Apply",
      locale: Locale('en'),
      titleName: "English",
    ),
    LocaleItem(
      applyText: "Appliquer",
      locale: Locale('fr'),
      titleName: "Français",
    ),
    LocaleItem(
      applyText: "Uygula",
      locale: Locale('tu'),
      titleName: "Türkçe",
    ),
    LocaleItem(
      applyText: "Anwenden",
      locale: Locale('de'),
      titleName: "Deutsch",
    ),
    LocaleItem(
      applyText: "Applicare",
      locale: Locale('it'),
      titleName: "Italiano",
    ),
    LocaleItem(
      applyText: "Aplicar",
      locale: Locale('es'),
      titleName: "Español",
    ),
    LocaleItem(
      applyText: "Aplicar",
      locale: Locale('pt'),
      titleName: "Português",
    ),
    LocaleItem(
      applyText: "Применять",
      locale: Locale('ru'),
      titleName: "Русский",
    ),
    LocaleItem(
      applyText: "应用",
      locale: Locale('zh'),
      titleName: "中文",
    ),
  ];

  static List<Locale> get locales => localeItems.map((e) => e.locale).toList();
  static String translationsPath = 'assets/translations';
  static Locale fallbackLocale = Locale('en');

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
      isSelected: true,
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
    SearchOption(
      name: 'A-Z',
      isSelected: true,
      searchFunction: (noteList, string) {
        noteList.sort((a, b) => a.event.content.compareTo(b.event.content));
        return noteList;
      },
      useSearchQuery: true,
    ),
  ];

  static List<SettingsItem> settings(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return <SettingsItem>[
      SettingsItem(
        icon: FlutterRemix.cloud_line,
        name: "relaysConfigs".tr(),
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
        name: "switchDarkMode".tr(),
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
        name: "myKeys".tr(),
        onTap: () {
          Navigator.of(context).pushNamed(Paths.myKeys);
        },
      ),
      SettingsItem(
        icon: FlutterRemix.translate,
        name: "changeLanguage".tr(),
        onTap: () {
          Routing.appCubit.showTranslationsSheet(context);
        },
      ),
      SettingsItem(
        icon: FlutterRemix.logout_box_line,
        name: "logout".tr(),
        onTap: () {
          cubit.logout(
            onSuccess: () {
              Navigator.of(context).pushReplacementNamed(Paths.onBoarding);
            },
          );
        },
      ),
    ];
  }

  static const List<String> chatMessagePlaceholders = <String>[
    'What is the meaning of the word "Islam"?',
    'Who is the prophet of Islam?',
    'What is the holy book of Islam called?',
    'What is the significance of the Kaaba in Islam?',
    'What is the difference between Sunni and Shia Muslims?',
    'What are the Five Pillars of Islam?',
    'What is the importance of prayer in Islam?',
    'What is the month of Ramadan and why is it important in Islam?',
    'What is Zakat and why is it important in Islam?',
    'What is the Islamic view on women\'s rights?',
    'What is the concept of Jihad in Islam?',
    'What is the Islamic view on homosexuality?',
    'What is the punishment for apostasy in Islam?',
    'What is the role of the mosque in Islamic worship?',
    'What is the significance of the Hajj pilgrimage in Islam?',
    'What is the Islamic perspective on other religions?',
    'What is the Islamic concept of afterlife?',
    'What is the Islamic stance on alcohol and drugs?',
    'What is the significance of the Friday prayer in Islam?',
    'What is the Islamic view on democracy and secularism?',
  ];

  static final version = '1.0.0';
}

import 'package:ditto/buisness_logic/app/app_cubit.dart';
import 'package:ditto/model/feed_category.dart';
import 'package:ditto/model/loclal_item.dart';
import 'package:ditto/model/search_option.dart';
import 'package:ditto/model/settings_item.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../buisness_logic/settings/settings_cubit.dart';
import '../env/env.dart';
import '../model/chat_modules.dart';
import '../model/relay_configuration.dart';
import '../model/report_option.dart';
import 'app_enums.dart';

abstract class AppConfigs {
  static const appName = "Al Ittihad";

  static const relaysUrls = [
    'wss://relay.nostr.band/all',
  ];

  static List<RelayConfiguration> get relaysConfigurations =>
      relaysUrls.map((url) {
        return RelayConfiguration(url: url);
      }).toList();

  static final List<FeedCategory> categories =
      RoundaboutTopics.values.map((topic) {
    return FeedCategory(
      name: topic.name.tr(),
      isSelected: false,
      enumValue: topic,
      feedPostsStream: NostrService.instance.subs.topic(
        topic: topic,
      ),
    );
  }).toList();

  static final localeItems = <LocaleItem>[
    const LocaleItem(
      applyText: "Apply",
      locale: Locale('en'),
      titleName: "English",
    ),
    // const LocaleItem(
    //  applyText: "تطبيق",
    //  locale: Locale('ar'),
    // titleName: "Arabic",
    //),
    // const LocaleItem(
    //   applyText: "Appliquer",
    //   locale: Locale('fr'),
    //   titleName: "Français",
    // ),
    // const LocaleItem(
    //   applyText: "Uygula",
    //   locale: Locale('tr'),
    //   titleName: "Türkçe",
    // ),
    // const LocaleItem(
    //   applyText: "Anwenden",
    //   locale: Locale('de'),
    //   titleName: "Deutsch",
    // ),
    // const LocaleItem(
    //   applyText: "Applicare",
    //   locale: Locale('it'),
    //   titleName: "Italiano",
    // ),
    // const LocaleItem(
    //   applyText: "Aplicar",
    //   locale: Locale('es'),
    //   titleName: "Español",
    // ),
    // const LocaleItem(
    //   applyText: "Aplicar",
    //   locale: Locale('pt'),
    //   titleName: "Português",
    // ),
    // const LocaleItem(
    //   applyText: "Применять",
    //   locale: Locale('ru'),
    //   titleName: "Русский",
    // ),
    // const LocaleItem(
    //   applyText: "应用",
    //   locale: Locale('zh'),
    //   titleName: "中文",
    // ),
  ];

  static const durationBetweenAIChatMessages = Duration(milliseconds: 25);

  static List<Locale> get locales => localeItems.map((e) => e.locale).toList();
  static String translationsPath = 'assets/translations';
  static Locale fallbackLocale = const Locale('en');

  static final feedsSearchOptions = <SearchOption>[
    SearchOption(
      name: "SearchByUsername".tr(),
      isSelected: false,
      searchFunction: (noteList, string) => noteList
          .where(
            (note) =>
                note.event.pubkey.toLowerCase().contains(string.toLowerCase()),
          )
          .toList(),
      useSearchQuery: true,
    ),
    SearchOption(
      name: 'newSearchbyKeyword'.tr(),
      isSelected: true,
      searchFunction: (noteList, string) => noteList
          .where(
            (note) =>
                note.event.content.toLowerCase().contains(string.toLowerCase()),
          )
          .toList(),
      useSearchQuery: true,
    ),
    SearchOption(
      name: 'newSearchByDate'.tr(),
      isSelected: false,
      searchFunction: (noteList, string) => noteList
          .where(
            (note) =>
                note.event.createdAt.toString().contains(string) ||
                note.event.createdAt.millisecondsSinceEpoch
                    .toString()
                    .contains(string),
          )
          .toList(),
      useSearchQuery: true,
    ),
    SearchOption(
      name: 'newSearchByHashtag'.tr(),
      isSelected: false,
      searchFunction: (noteList, string) => noteList
          .where(
            (note) => note.event.content
                .toLowerCase()
                .contains('#$string'.toLowerCase()),
          )
          .toList(),
      useSearchQuery: true,
    ),
    SearchOption(
      name: 'newImageOnly'.tr(),
      isSelected: false,
      searchFunction: (noteList, string) =>
          noteList.where((note) => note.imageLinks.isNotEmpty).toList(),
      useSearchQuery: false,
    ),
    SearchOption(
      name: 'az'.tr(),
      isSelected: true,
      searchFunction: (noteList, string) {
        noteList.sort((a, b) => a.event.content.compareTo(b.event.content));
        return noteList;
      },
      useSearchQuery: true,
      manipulatesExistingResultsList: true,
    ),
  ];

  static List<SettingsItem> settings(BuildContext context) {
    final cubit = context.read<SettingsCubit>();

    return <SettingsItem>[
      SettingsItem(
        icon: FlutterRemix.cloud_line,
        name: "relays".tr(),
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
        icon: FlutterRemix.key_line,
        name: "keys".tr(),
        onTap: () {
          Navigator.of(context).pushNamed(Paths.myKeys);
        },
      ),
      SettingsItem(
        icon: FlutterRemix.translate,
        name: "languages".tr(),
        onTap: () {
          Routing.appCubit.showTranslationsSheet(context);
        },
      ),
      SettingsItem(
        icon: FlutterRemix.moon_line,
        name: "themes".tr(),
        onTap: () {
          cubit.switchDarkMode();
        },
        trailing: Transform.scale(
          alignment: Alignment.centerRight,
          scale: .75,
          child: Switch(
            value: LocalDatabase.instance.getThemeState() ?? context.isDarkMode,
            onChanged: (value) {
              cubit.switchDarkMode();
            },
          ),
        ),
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

  static List<String> get defaultQuestions =>
      "defaultQuestions".tr().split('\n');

  static ChatModuleItem get defaultChatModule => ChatModuleItem(
        title: "roundaboutGPT".tr(),
        subtitle: "chatSubtitle".tr(),
        imageIcon: "",
        instruction:
            "Be a chatbot assistant and help users with their questions.",
        recommendedQuestions: AppConfigs.defaultQuestions,
      );

  static List<ReportOption> reportOptions =
      ReportType.values.map((type) => ReportOption(reportType: type)).toList();

  static const showPreviewMode = false;
  static const version = Env.appVersion;

  static final feedDateRangePickerFirstDate = DateTime(2015, 8);
  static DateTime get feedDateRangePickerLastDate => DateTime.now();
}

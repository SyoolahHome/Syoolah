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
import '../model/relay_configuration.dart';
import '../model/report_option.dart';
import 'app_enums.dart';

abstract class AppConfigs {
  static const appName = "Umrahty";
  static const relaysUrls = [
    'wss://relay.munawarah.me',
    'wss://umrah.relay.munawarah.me',
    'wss://nostr.fmt.wiz.biz',
    'wss://relay.damus.io',
    'wss://nostr-pub.wellorder.net',
    'wss://relay.nostr.info',
    'wss://offchain.pub',
    'wss://nos.lol',
    'wss://relay.nostr.band',
    'wss://relay.snort.social',
    'wss://relay.current.fyi',
  ];

  static List<RelayConfiguration> get relaysConfigurations =>
      relaysUrls.map((url) {
        return RelayConfiguration(url: url);
      }).toList();

  static final List<FeedCategory> categories =
      UmrahtyTopics.values.map((topic) {
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
    const LocaleItem(
      applyText: "تطبيق",
      locale: Locale('ar'),
      titleName: "Arabic",
    ),
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
  static Locale fallbackLocale = const Locale('ar');

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

  static List<String> chatMessagePlaceholders = <String>[
    ...AppConfigs.beginnerRecommendedQuestions,
    ...AppConfigs.intermediateRecommendQuestions,
    ...AppConfigs.advancedRecommendQuestions,
  ];

  static List<String> get beginnerRecommendedQuestions =>
      "defaultQuestions".tr().split('\n');

  static final intermediateRecommendQuestions = const <String>[
    "What are the essential steps involved in performing Umrah?",
    "How does Hajj differ from Umrah in terms of rituals and significance?",
    "What is the Ihram and what are its conditions for pilgrims?",
    "Can you explain the importance of the Tawaf and Sa'i in Umrah and Hajj?",
    "What is the historical significance of the Kaaba in Islam?",
    "What are the specific days of Hajj and what happens on each day?",
    "How can one prepare spiritually and physically for Hajj and Umrah?",
    "What are the common mistakes to avoid during Hajj and Umrah?",
    "What are the permissible actions while in a state of Ihram?",
    "How is the ritual of stoning the Jamarat performed and what does it symbolize?",
    "What are the conditions that make Hajj compulsory for a Muslim?",
    "Can Hajj and Umrah be performed on behalf of someone else?",
    "What is the Miqat and why is it important for pilgrims?",
    "How do the rituals of Hajj and Umrah promote unity among Muslims?",
    "What is the significance of the Day of Arafah during Hajj?",
    "How should pilgrims deal with the physical challenges of Hajj?",
    "What are the major and minor sins that can invalidate Hajj?",
    "How can international pilgrims navigate language barriers in Saudi Arabia?",
    "What are the best practices for staying healthy during Hajj and Umrah?",
    "How do pilgrims perform the farewell Tawaf?",
    "What role does patience play in the experience of Hajj and Umrah?",
    "How has the practice of Hajj evolved over the centuries?",
    "What are the environmental considerations for Hajj and Umrah pilgrims?",
    "How can pilgrims ensure their Hajj is accepted by Allah?",
    "What are the guidelines for women performing Hajj and Umrah?",
    "Can children perform Hajj and Umrah, and what are the rules for them?",
    "What are the visa requirements for Hajj and Umrah pilgrims?",
    "How do pilgrims manage their finances during Hajj and Umrah?",
    "What is the significance of cutting or shaving hair after Umrah or Hajj?",
    "How do pilgrims maintain their spiritual gains after returning from Hajj or Umrah?",
    "What are the recommended Du'as and prayers during Tawaf and Sa'i?",
    "How should pilgrims dress during Ihram, and why?",
    "What is the meaning and importance of sacrificing an animal during Hajj?",
    "How can technology enhance the Hajj and Umrah experience for pilgrims?",
    "What are the security measures in place for Hajj and Umrah?",
    "How do pilgrims perform the ritual of Tawaf al-Ifadah?",
    "What are the rules regarding menstruation and performing Hajj or Umrah?",
    "How can pilgrims contribute to the local economy during their stay?",
    "What is the Ziyarah, and how is it performed in Medina?",
  ];

  static final advancedRecommendQuestions = const <String>[
    "What are the essential steps involved in performing Umrah?",
    "How does Hajj differ from Umrah in terms of rituals and significance?",
    "What is the Ihram and what are its conditions for pilgrims?",
    "Can you explain the importance of the Tawaf and Sa'i in Umrah and Hajj?",
    "What is the historical significance of the Kaaba in Islam?",
    "What are the specific days of Hajj and what happens on each day?",
    "How can one prepare spiritually and physically for Hajj and Umrah?",
    "What are the common mistakes to avoid during Hajj and Umrah?",
    "What are the permissible actions while in a state of Ihram?",
    "How is the ritual of stoning the Jamarat performed and what does it symbolize?",
    "What are the conditions that make Hajj compulsory for a Muslim?",
    "Can Hajj and Umrah be performed on behalf of someone else?",
    "What is the Miqat and why is it important for pilgrims?",
    "How do the rituals of Hajj and Umrah promote unity among Muslims?",
    "What is the significance of the Day of Arafah during Hajj?",
    "How should pilgrims deal with the physical challenges of Hajj?",
    "What are the major and minor sins that can invalidate Hajj?",
    "How can international pilgrims navigate language barriers in Saudi Arabia?",
    "What are the best practices for staying healthy during Hajj and Umrah?",
    "How do pilgrims perform the farewell Tawaf?",
    "What role does patience play in the experience of Hajj and Umrah?",
    "How has the practice of Hajj evolved over the centuries?",
    "What are the environmental considerations for Hajj and Umrah pilgrims?",
    "How can pilgrims ensure their Hajj is accepted by Allah?",
    "What are the guidelines for women performing Hajj and Umrah?",
    "Can children perform Hajj and Umrah, and what are the rules for them?",
    "What are the visa requirements for Hajj and Umrah pilgrims?",
    "How do pilgrims manage their finances during Hajj and Umrah?",
    "What is the significance of cutting or shaving hair after Umrah or Hajj?",
    "How do pilgrims maintain their spiritual gains after returning from Hajj or Umrah?",
    "What are the recommended Du'as and prayers during Tawaf and Sa'i?",
    "How should pilgrims dress during Ihram, and why?",
    "What is the meaning and importance of sacrificing an animal during Hajj?",
    "How can technology enhance the Hajj and Umrah experience for pilgrims?",
    "What are the security measures in place for Hajj and Umrah?",
    "How do pilgrims perform the ritual of Tawaf al-Ifadah?",
    "What are the rules regarding menstruation and performing Hajj or Umrah?",
    "How can pilgrims contribute to the local economy during their stay?",
    "What is the Ziyarah, and how is it performed in Medina?",
  ];

  static List<ReportOption> reportOptions =
      ReportType.values.map((type) => ReportOption(reportType: type)).toList();

  static const showPreviewMode = false;
  static const version = Env.appVersion;

  static final feedDateRangePickerFirstDate = DateTime(2015, 8);
  static DateTime get feedDateRangePickerLastDate => DateTime.now();
}

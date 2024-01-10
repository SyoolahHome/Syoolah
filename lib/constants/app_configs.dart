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

  static List<RelayConfiguration> get relaysConfigurations =>
      relaysUrls.map((url) {
        return RelayConfiguration(url: url);
      }).toList();

  static final List<FeedCategory> categories = [
    FeedCategory(
      name: "redbull".tr(),
      imageIcon: "assets/teams/red-bull-racing.png",
      isSelected: false,
      enumValue: SakhirTopics.redbull,
      feedPostsStream: NostrService.instance.subs.topic(
        topic: SakhirTopics.redbull,
      ),
    ),
    FeedCategory(
      name: "mercedes".tr(),
      imageIcon: "assets/teams/mercedes.png",
      isSelected: false,
      enumValue: SakhirTopics.mercedes,
      feedPostsStream: NostrService.instance.subs.topic(
        topic: SakhirTopics.mercedes,
      ),
    ),
    FeedCategory(
      name: "aston_martin".tr(),
      imageIcon: "assets/teams/aston-martin.png",
      isSelected: false,
      enumValue: SakhirTopics.astonMartin,
      feedPostsStream: NostrService.instance.subs.topic(
        topic: SakhirTopics.astonMartin,
      ),
    ),
    FeedCategory(
      name: "ferrari".tr(),
      imageIcon: "assets/teams/ferrari.png",
      isSelected: false,
      enumValue: SakhirTopics.ferrari,
      feedPostsStream: NostrService.instance.subs.topic(
        topic: SakhirTopics.ferrari,
      ),
    ),
    FeedCategory(
      name: "mclaren".tr(),
      imageIcon: "assets/teams/mclaren.png",
      isSelected: false,
      enumValue: SakhirTopics.mclaren,
      feedPostsStream: NostrService.instance.subs.topic(
        topic: SakhirTopics.mclaren,
      ),
    ),
    FeedCategory(
      name: "alpine".tr(),
      imageIcon: "assets/teams/alpine.png",
      isSelected: false,
      enumValue: SakhirTopics.alpine,
      feedPostsStream: NostrService.instance.subs.topic(
        topic: SakhirTopics.alpine,
      ),
    ),
    FeedCategory(
      name: "williams".tr(),
      imageIcon: "assets/teams/williams.png",
      isSelected: false,
      enumValue: SakhirTopics.williams,
      feedPostsStream: NostrService.instance.subs.topic(
        topic: SakhirTopics.williams,
      ),
    ),
    FeedCategory(
      name: "haasf1team".tr(),
      imageIcon: "assets/teams/haas-f1-team.png",
      isSelected: false,
      enumValue: SakhirTopics.haasf1team,
      feedPostsStream: NostrService.instance.subs.topic(
        topic: SakhirTopics.haasf1team,
      ),
    ),
    FeedCategory(
      name: "alfaromeo".tr(),
      imageIcon: "assets/teams/alfa-romeo.png",
      isSelected: false,
      enumValue: SakhirTopics.alfaromeo,
      feedPostsStream: NostrService.instance.subs.topic(
        topic: SakhirTopics.alfaromeo,
      ),
    ),
    FeedCategory(
      name: "alphatauri".tr(),
      imageIcon: "assets/teams/alphatauri.png",
      isSelected: false,
      enumValue: SakhirTopics.alphatauri,
      feedPostsStream: NostrService.instance.subs.topic(
        topic: SakhirTopics.alphatauri,
      ),
    ),
  ];

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
    const LocaleItem(
      applyText: "Appliquer",
      locale: Locale('fr'),
      titleName: "Français",
    ),
    const LocaleItem(
      applyText: "Uygula",
      locale: Locale('tr'),
      titleName: "Türkçe",
    ),
    const LocaleItem(
      applyText: "Anwenden",
      locale: Locale('de'),
      titleName: "Deutsch",
    ),
    const LocaleItem(
      applyText: "Applicare",
      locale: Locale('it'),
      titleName: "Italiano",
    ),
    const LocaleItem(
      applyText: "Aplicar",
      locale: Locale('es'),
      titleName: "Español",
    ),
    const LocaleItem(
      applyText: "Aplicar",
      locale: Locale('pt'),
      titleName: "Português",
    ),
    const LocaleItem(
      applyText: "Применять",
      locale: Locale('ru'),
      titleName: "Русский",
    ),
    const LocaleItem(
      applyText: "应用",
      locale: Locale('zh'),
      titleName: "中文",
    ),
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

  static List<String> chatMessagePlaceholders = <String>[
    ...AppConfigs.beginnerRecommendedQuestions,
    ...AppConfigs.intermediateRecommendQuestions,
    ...AppConfigs.advancedRecommendQuestions,
  ];

  static final beginnerRecommendedQuestions = const <String>[
    "Who is the current Formula 1 World Champion?",
    "What is the name of the most famous Formula 1 team?",
    "How many races are there in a typical F1 season?",
    "Explain what DRS (Drag Reduction System) is.",
    "What is the purpose of the Safety Car in F1 races?",
    "Can you name a famous F1 race track?",
    "What does 'pole position' mean in Formula 1?",
    "Who is Lewis Hamilton, and why is he famous in F1?",
    "What is the FIA in Formula 1?",
    "What are the primary tire suppliers in F1?",
        "What is the role of a race engineer in Formula 1?",
    "Explain the concept of 'overtaking' in F1 races.",
    "Who is the founder of Formula 1?",
    "What is the F1 Constructors' Championship, and how is it determined?",
    "Describe the function of F1 team principals.",
    "What is the role of the FIA Stewards during an F1 race?",
    "How are F1 drivers selected to join a team?",
    "Explain the meaning of 'blue flags' in Formula 1.",
    "What are the 'marbles' on the track, and how do they affect racing?",
    "What is the significance of the F1 Drivers' Parade?"
 
  ];

  static final intermediateRecommendQuestions = const <String>[
    "Describe the role of a pit crew during an F1 race.",
    "What are the key components of an F1 car's aerodynamics?",
    "Explain the concept of tire compounds in Formula 1.",
    "How are F1 races scored, and what are the points awarded for various positions?",
    "Describe the significance of the 'fastest lap' in an F1 race.",
    "What is a 'formation lap,' and why is it done before the start of an F1 race?",
    "Can you name some famous F1 drivers from the past?",
    "What are the differences between a wet and dry setup for an F1 car?",
    "How do F1 teams plan their pit stops during a race?",
    "What are the common pit stop strategies in Formula 1?",
         "Describe the impact of F1 regulations on car design and performance.",
    "Explain the concept of 'aero push' in Formula 1 racing.",
    "What are the different types of wet weather tires used in F1?",
    "How do F1 teams manage their budgets and sponsorships?",
    "Describe the evolution of F1 cars over the years in terms of technology.",
    "What are the penalties for exceeding track limits in F1 races?",
    "How do F1 teams utilize wind tunnel testing for car development?",
    "Explain the concept of 'ground effect' in F1 aerodynamics.",
    "What is the 'parc fermé' rule in Formula 1, and when does it apply?",
    "Describe the role of race strategy engineers in F1 teams."
   
  ];

  static final advancedRecommendQuestions = const <String>[
    "Explain the concept of ERS (Energy Recovery System) in Formula 1.",
    "How do F1 teams strategize for tire changes during a race?",
    "Describe the role of aerodynamic downforce in F1 car performance.",
    "What is the difference between a V6 and a V8 engine in F1?",
    "How do F1 teams collect and analyze telemetry data during a race?",
    "What is the 'F1 Technical Directive' and its significance?",
    "Explain the impact of track temperature on tire performance in F1.",
    "What are the key elements of an F1 team's race weekend strategy?",
    "How does DRS (Drag Reduction System) activation work?",
    "What is the role of the FIA Race Director in Formula 1?",
      "Explain the impact of hybrid power units on F1 racing.",
    "Describe the process of designing and building an F1 race circuit.",
    "What is the 'F1 Technical Working Group,' and what is its role?",
    "How do F1 teams manage their data security and protect intellectual property?",
    "Explain the concept of 'flow-vis paint' in aerodynamic testing.",
    "What is the role of a simulator driver in F1 teams?",
    "Describe the advancements in F1 safety technology over the years.",
    "How do F1 teams optimize fuel efficiency during a race?",
    "Explain the concept of 'dirty air' and its impact on car performance.",
    "What are the challenges of Formula 1 racing in extreme weather conditions?"
  
  ];

  static List<ReportOption> reportOptions =
      ReportType.values.map((type) => ReportOption(reportType: type)).toList();

  static const showPreviewMode = false;
  static const version = Env.appVersion;

  static final feedDateRangePickerFirstDate = DateTime(2015, 8);
  static DateTime get feedDateRangePickerLastDate => DateTime.now();
}

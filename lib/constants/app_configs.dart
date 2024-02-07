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
    'wss://relay.umrahty.one',
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
    "How can I enhance the security and privacy of my online accounts?",
    "What are the latest cybersecurity news and threats?",
    "Can you share any recent reports or research findings on AI in healthcare?",
    "Explain the role of cryptography in securing blockchain transactions.",
    "What are the key applications of artificial intelligence in networking?",
    "How can I start a career in programming with a focus on AI technologies?",
    "What are the challenges and solutions in distributed systems networking?",
    "Can you recommend a programming language for developing blockchain applications?",
    "What are some real-world use cases of blockchain technology?",
    "How do distributed systems contribute to cloud computing?",
    "Tell me about data science techniques for analyzing IoT data.",
    "What are the public safety implications of IoT devices?",
    "Explain the role of cloud and virtualization in data science.",
    "How does blockchain technology enhance data security?",
    "What is the impact of artificial intelligence on public safety?",
    "How can I secure my IoT devices from potential threats?",
    "What are the emerging security and privacy challenges in IoT?",
    "Can you provide news updates on recent blockchain developments?",
    "What reports and research are available on the adoption of AI in education?",
    "How does cryptography play a role in securing IoT communications?",
    "What are the ethical considerations in artificial intelligence research?",
    "What programming languages are commonly used in developing AI applications?",
    "Tell me about the technologies used in distributed ledger systems.",
    "What are some blockchain-based applications for supply chain management?",
    "How can I implement AI-powered networking solutions in my organization?",
    "What are the advantages of using virtualization in cloud computing?",
    "Explain the concept of edge computing in IoT.",
    "Can you recommend programming resources for learning about data science?",
    "What is the significance of blockchain consensus mechanisms?",
    "How does AI assist in public safety operations?",
    "What are the networking challenges in building distributed systems?",
    "How can I secure my cloud-based applications and data?",
    "What tools and frameworks are commonly used in AI development?",
    "Tell me about the role of blockchain in financial technologies (FinTech).",
    "What are some examples of AI-driven networking optimization?",
    "How do data science and machine learning intersect?",
    "What are the security implications of AI-driven autonomous vehicles?",
    "Can you provide updates on recent developments in IoT technology?",
    "How does virtualization improve resource utilization in cloud environments?",
    "What are the privacy concerns related to AI-powered surveillance systems?",
    "Explain the concept of consensus algorithms in distributed systems.",
    "What are the applications of blockchain beyond cryptocurrencies?",
    "How can AI be used to enhance public safety in smart cities?",
    "What are the challenges of implementing AI in networking infrastructure?",
    "What is the role of data analytics in optimizing cloud performance?",
    "Tell me about the advantages of decentralized applications (DApps) in blockchain.",
    "How do edge devices communicate in an IoT ecosystem?",
    "What programming languages are suitable for building secure IoT applications?",
    "What are the cybersecurity measures for protecting cloud-based data?",
    "How can I secure my IoT devices from potential threats?",
    "What are the emerging security and privacy challenges in IoT?",
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

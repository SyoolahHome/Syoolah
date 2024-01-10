import 'dart:math';

import 'package:dart_nostr/nostr/model/relay_informations.dart';
import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/model/bottom_sheet_option.dart';
import 'package:ditto/model/chat_message.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/model/relay_configuration.dart';
import 'package:ditto/presentation/add_relay/add_relay.dart';
import 'package:ditto/presentation/feeds/widgets/search.dart';
import 'package:ditto/presentation/general/pattern_widget.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/new_post/add_new_post.dart';
import 'package:ditto/presentation/private_succes/private_key.dart';
import 'package:ditto/presentation/private_succes/private_key_gen_success.dart';
import 'package:ditto/presentation/profile_options/profile_options.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../buisness_logic/lnd/lnd_cubit.dart';
import '../../constants/app_enums.dart';
import '../../presentation/general/widget/bottom_sheet_title_with_button.dart';
import '../../presentation/general/widget/margined_body.dart';
import '../../presentation/general/widget/note_card/wudgets/note_youtube_player.dart';
import '../../presentation/lnd/widgets/bottom_sheet_widget.dart';
import '../../presentation/lnd/widgets/lnd_invoice_adress_prompt copy.dart';
import '../../presentation/lnd/widgets/user_adress_prompt.dart';
import '../../presentation/onboarding_search/widgets/sheet_metadata.dart';
import '../../presentation/report/report.dart';

abstract class BottomSheetService {
  static Future showCreatePostBottomSheet(
    BuildContext context, {
    String? initialNoteContent,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return AddNewPost(
          initialNoteContent: initialNoteContent,
          expectMultiLine: true,
        );
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future noteComments(
    BuildContext context, {
    required Note note,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return Container();
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future showSearch(BuildContext context, GlobalFeedCubit cubit) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return SearchSections(cubit: cubit);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showProfileBottomSheet(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetOptionsWidget(options: options);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showNoteCardSheet(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return BottomSheetOptionsWidget(options: options);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showAddRelaySheet({
    required BuildContext context,
    required Future<void> Function() onAdd,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return AddRelayWidget(onAdd: onAdd);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showOnBoardingSearchSheet(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return AppUtils.instance
            .widgetFromRoutePath(Paths.onBoardingSearch, context);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showOnBoardingRelaysSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return AppUtils.instance
            .widgetFromRoutePath(Paths.onBoardingRelays, context);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showRelayOptionsSheet({
    required BuildContext context,
    required RelayConfiguration relay,
    required List<BottomSheetOption> options,
    RelayInformations? relayInformations,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return BottomSheetOptionsWidget(
          options: options,
          title: relayInformations?.name != null
              ? "relayName".tr(args: [relayInformations!.name])
              : "",
        );
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showOnBoardingTranslationsSheet(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return BottomSheetOptionsWidget(
          options: options,
          title: "translations".tr(),
        );
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showRouteAsBottomSheet(
    BuildContext context, {
    required String route,
    double? height,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return SizedBox(
          height: height,
          child: AppUtils.instance.widgetFromRoutePath(route, context),
        );
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future showPrivateKeyGenSuccess(
    BuildContext context, {
    required VoidCallback onCopy,
    String? customText,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return PrivateKeyGenSuccess(
          onCopy: onCopy,
          customText: customText,
        );
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: false,
    );
  }

  static Future<void> showKey(
    BuildContext context, {
    required HiddenPrivateKeySectionType type,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: PrivateKey(
            type: type,
            title: type == HiddenPrivateKeySectionType.privateKey
                ? "myPrivateKey".tr()
                : "myNsecKey".tr(),
          ),
        );
      },
    );
  }

  static Future<void> showProfileFollowings(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return BottomSheetOptionsWidget(options: options);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showChatMessageOptionsSheet(
    BuildContext context, {
    required ChatMessage message,
    required List<BottomSheetOption> options,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return BottomSheetOptionsWidget(
          options: options,
          title:
              '${message.message.substring(0, min(message.message.length, 20))}...',
        );
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showChatOptionsSheet(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return BottomSheetOptionsWidget(options: options);
      },
    );
  }

  static Future showYoututbeVideoBottomSheet(
    BuildContext context, {
    required String url,
    required VoidCallback onAccept,
    required VoidCallback onRemove,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      clipBehavior: Clip.hardEdge,

      // isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return PatternScaffold(
          body: Container(
            padding: EdgeInsets.all(MarginedBody.defaultMargin.left),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BottomSheetTitleWithIconButton(title: "youtubeVideo".tr()),
                SizedBox(height: 15),
                NoteYoutubePlayer(url: url),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 35,
                      child: SakhirButton(
                        onTap: () {
                          onRemove();
                          Navigator.of(context).pop();
                        },
                        text: "remove".tr(),
                        isSmall: true,
                        isOnlyBorder: true,
                        mainColor: Colors.red,
                        icon: FlutterRemix.close_fill,
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: SakhirButton(
                        onTap: () {
                          onAccept();
                          Navigator.of(context).pop();
                        },
                        text: "accept".tr(),
                        isSmall: true,
                        mainColor: Colors.green,
                        icon: FlutterRemix.check_line,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showReportSheet(BuildContext context, Note note) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return ReportSheetWidget(
          note: note,
          noteCardContext: context,
        );
      },
    );
  }

  static void showWidgetAsBottomSheet(
    Widget screen,
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return screen;
      },
    );
  }

  static void showOnBoardingSearchUserMetadataPropertiesSheet(
    BuildContext context, {
    required Iterable<MapEntry<String, dynamic>> properties,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return OnBoardingSearchUserMetadataPropertiesSheet(
          properties: properties,
        );
      },
    );
  }

  static Future<void> showCommentOptions(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetOptionsWidget(options: options);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static void createLndAddress(LndCubit lndCubit, BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return LndAdressCreationWidget(
          lndCubit: lndCubit,
        );
      },
    );
  }

  static Future<String> promptUserForAddress(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return UserAddressPromptWidget();
      },
    );
  }

  static promptUserForInvoice({
    required BuildContext context,
    required void Function(String) onSubmit,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return UserLndInvoicePromptWidget(
          onSubmit: onSubmit,
        );
      },
    );
  }

  static Future<String?> promptUserForNewLndUsername({
    required BuildContext context,
  }) async {
    final random = Random().nextInt(100000).toString();

    return "anas $random";

// !
    throw UnimplementedError();
    // return showModalBottomSheet<String?>(
    //   context: context,
    //   builder: (context) {
    //     return UserLndUsernamePromptWidget();
    //   },
    // );
  }
}

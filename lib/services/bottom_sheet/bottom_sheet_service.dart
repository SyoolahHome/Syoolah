import 'dart:math';

import 'package:dart_nostr/nostr/model/relay_informations.dart';
import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/model/chat_message.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/model/relay_configuration.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../model/bottom_sheet_option.dart';
import '../../presentation/add_relay/add_relay.dart';
import '../../presentation/current_user_keys/widgets/private_key_section.dart';
import '../../presentation/feeds/widgets/search.dart';
import '../../presentation/new_post/add_new_post.dart';
import '../../presentation/private_succes/private_key.dart';
import '../../presentation/private_succes/private_key_gen_success.dart';
import '../../presentation/profile_options/profile_options.dart';
import '../../presentation/youtube_video_widget/youtube_video_widget.dart';
import '../utils/paths.dart';

abstract class BottomSheetService {
  static showCreatePostBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return const AddNewPost();
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static noteComments(
    BuildContext context, {
    required Note note,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container();
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static showSearch(BuildContext context, GlobalFeedCubit cubit) {
    return showModalBottomSheet(
      context: context,
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
      builder: (context) {
        return AppUtils.widgetFromRoutePath(Paths.onBoardingSearch, context);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showOnBoardingRelaysSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return AppUtils.widgetFromRoutePath(Paths.onBoardingRelays, context);
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
      builder: (context) {
        return BottomSheetOptionsWidget(
          options: options,
          title: "relayName".tr(args: [relayInformations!.name]),
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
    String route,
    BuildContext context, {
    double? height,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: height,
          child: AppUtils.widgetFromRoutePath(route, context),
        );
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future showPrivateKeyGenSuccess(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return const PrivateKeyGenSuccess();
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
      builder: (context) {
        return BottomSheetOptionsWidget(
          options: options,
          title: message.message.substring(0, min(message.message.length, 20)) +
              '...',
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
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return BottomSheetOptionsWidget(options: options);
      },
    );
  }

  static showYoututbeVideoBottomSheet(
    BuildContext context, {
    required String url,
    required VoidCallback onAccept,
  }) {
    return showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return YoutubeVideoWidget(
          url: url,
          onAccept: onAccept,
        );
      },
    );
  }
}

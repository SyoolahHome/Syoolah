import 'package:dart_nostr/nostr/model/relay_informations.dart';
import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/constants/strings.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/model/relat_configuration.dart';
import 'package:ditto/services/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../model/profile_option.dart';
import '../../presentation/add_relay/add_relay.dart';
import '../../presentation/feeds/widgets/search.dart';
import '../../presentation/new_post/add_new_post.dart';
import '../../presentation/profile_options/profile_options.dart';
import '../utils/paths.dart';

abstract class BottomSheetService {
  static showCreatePostBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return const AddNewPost();
      },
    );
  }

  static noteComments(
    BuildContext context, {
    required Note note,
  }) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return Container();
      },
    );
  }

  static showSearch(BuildContext context, FeedCubit cubit) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return SearchSections(cubit: cubit);
      },
    );
  }

  static Future<void> showProfileBottomSheet(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return BottomSheetOptionsWidget(
          options: options,
        );
      },
    );
  }

  static Future<void> showNoteCardSheet(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return BottomSheetOptionsWidget(
          options: options,
        );
      },
    );
  }

  static void showAddRelaySheet({
    required BuildContext context,
    required Future<void> Function() onAdd,
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return AddRelayWidget(
          onAdd: onAdd,
        );
      },
    );
  }

  static Future<void> showOnBoardingSearchSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return AppUtils.widgetFromRoutePath(Paths.onBoardingSearch, context);
      },
    );
  }

  static Future<void> showOnBoardingRelaysSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return AppUtils.widgetFromRoutePath(Paths.onBoardingRelays, context);
      },
    );
  }

  static void showRelayOptionsSheet({
    required BuildContext context,
    required RelayConfiguration relay,
    required List<BottomSheetOption> options,
    RelayInformations? relayInformations,
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return BottomSheetOptionsWidget(
          title: AppStrings.relayName(relayInformations?.name),
          options: options,
        );
      },
    );
  }

  static void showOnBoardingTranslationsSheet(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return BottomSheetOptionsWidget(
          title: AppStrings.translations,
          options: options,
        );
      },
    );
  }
}

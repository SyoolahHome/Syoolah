import 'package:dart_nostr/nostr/model/relay_informations.dart';
import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/constants/app_strings.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/model/relay_configuration.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:flutter/material.dart';

import '../../model/bottom_sheet_option.dart';
import '../../presentation/add_relay/add_relay.dart';
import '../../presentation/feeds/widgets/search.dart';
import '../../presentation/new_post/add_new_post.dart';
import '../../presentation/private_succes/private_key_gen_success.dart';
import '../../presentation/profile_options/profile_options.dart';
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
          title: AppStrings.relayName(relayInformations?.name),
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
          title: AppStrings.translations,
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
}

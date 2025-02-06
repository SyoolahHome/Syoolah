import 'package:bloc/bloc.dart';
import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/model/bottom_bar_item.dart';
import 'package:ditto/presentation/dms/dms.dart';
import 'package:ditto/presentation/feeds/global_feed.dart';
import 'package:ditto/presentation/navigations_screen/home/home.dart';
import 'package:ditto/presentation/navigations_screen/profile/profile.dart';
import 'package:ditto/presentation/wallet_v2/wallet_v2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../presentation/lnd/lnd.dart';
import '../../presentation/translation/translation.dart';
import '../../services/database/local/local_database.dart';

class BottomBarCubit extends Cubit<int> {
  /// {@template _shouldShowLeadingOnProfile}
  /// Weither to show a leading back icon button on the profile screen.
  /// {@endtemplate}
  bool _shouldShowLeadingOnProfile = false;

  /// {@macro _shouldShowLeadingOnProfile}
  bool get shouldShowLeadingOnProfile => _shouldShowLeadingOnProfile;

  /// A List of items to be shown and handled by the bottom bar in the UI..
  List<BottomBarItem> get items {
    final privateKey = LocalDatabase.instance.getPrivateKey()!;
    final currentUserPubKey =
        Nostr.instance.keysService.derivePublicKey(privateKey: privateKey);

    return <BottomBarItem>[
      BottomBarItem(
        screen: const Home(),
        label: 'home'.tr(),
        icon: FlutterRemix.home_4_line,
        selectedIcon: FlutterRemix.home_4_fill,
      ),
      BottomBarItem(
        screen: Profile(
          userPubKey: currentUserPubKey,
        ),
        label: 'profile'.tr(),
        icon: FlutterRemix.user_line,
        selectedIcon: FlutterRemix.user_fill,
      ),
      BottomBarItem(
        screen: null,
        svgIconPath: "assets/images/GPT.svg",
        label: 'roundaboutGPT'.tr(),
        icon: FlutterRemix.message_3_line,
        selectedIcon: FlutterRemix.message_3_fill,
      ),
      BottomBarItem(
        screen: Umah(),
        label: 'global'.tr(),
        icon: Icons.people_outline_sharp,
        selectedIcon: Icons.people_sharp,
      ),
      if (AppConfigs.enableLnd) ...[
        BottomBarItem(
          screen: LND(
            showNoSupport: false,
          ),
          label: 'lnd'.tr(),
          icon: FlutterRemix.flashlight_line,
          selectedIcon: FlutterRemix.flashlight_fill,
        ),
        BottomBarItem(
          screen: WalletVersionTwo(),
          label: 'wallet'.tr(),
          icon: FlutterRemix.wallet_2_line,
          selectedIcon: FlutterRemix.wallet_2_fill,
        ),
      ],
      if (AppConfigs.enableTranslation)
        BottomBarItem(
          screen: Translation(),
          label: 'translate'.tr(),
          icon: FlutterRemix.translate_2,
          selectedIcon: FlutterRemix.translate_2,
        ),
      if (AppConfigs.enableDms)
        BottomBarItem(
          screen: DMS(),
          label: 'dms'.tr(),
          icon: FlutterRemix.message_2_line,
          selectedIcon: FlutterRemix.message_2_fill,
        ),
    ];
  }

  List<BottomBarItem> get itemsToShowInBottomBarScreen =>
      items.take(items.length - 1).toList();

  BottomBarCubit() : super(0) {
    final indexOfProfile = items.indexWhere(
      (element) => element.screen is Umah,
    );

    emit(indexOfProfile);
  }

  /// Emits a new state on the tapped bottom bar item and reflects changes in the UI.
  void onItemTapped(
    int index, {
    bool shouldShowLeadingOnProfile = false,
  }) {
    _shouldShowLeadingOnProfile = shouldShowLeadingOnProfile;
    emit(index);
  }
}

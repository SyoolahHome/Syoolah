import 'package:ditto/model/drawer_list_time_item.dart';
import 'package:ditto/presentation/navigations_screen/profile/profile.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../buisness_logic/bottom_bar/bottom_bar_cubit.dart';

abstract class GeneralDrawerItems {
  static List<DrawerListTimeItem> drawerListTileItems(
    BuildContext context, {
    required BottomBarCubit bottomBarCubit,
  }) =>
      [
        DrawerListTimeItem(
          icon: FlutterRemix.information_line,
          label: 'about'.tr(),
          onTap: () {
            Navigator.of(context).pushNamed(Paths.aboutApp);
          },
        ),
        DrawerListTimeItem(
          icon: FlutterRemix.user_line,
          label: "profile".tr(),
          onTap: () {
            final indexOfProfile = bottomBarCubit.items.indexWhere(
              (element) => element.screen is Profile,
            );

            bottomBarCubit.onItemTapped(indexOfProfile);
          },
        ),
        DrawerListTimeItem(
          icon: Icons.verified_outlined,
          label: "lightningAddresses".tr(),
          onTap: () {
            Navigator.of(context).pushNamed(Paths.nip05Verification);
          },
        ),
        // DrawerListTimeItem(
        //   icon: FlutterRemix.key_line,
        //   label: "keys".tr(),
        //   onTap: () {
        //     Navigator.of(context).pushNamed(
        //       Paths.myKeys,
        //     );
        //   },
        // ),
        DrawerListTimeItem(
          icon: FlutterRemix.settings_line,
          label: 'settings'.tr(),
          onTap: () {
            Navigator.of(context).pushNamed(
              Paths.settings,
            );
          },
        ),
        // DrawerListTimeItem(
        //   icon: FlutterRemix.shield_user_line,
        //   label: 'privacyPolicy'.tr(),
        //   onTap: () {
        //     Navigator.of(context).pushNamed(Paths.privacyPolicy);
        //   },
        // ),
        DrawerListTimeItem(
          icon: FlutterRemix.logout_box_line,
          label: "logout".tr(),
          isLogout: true,
          onTap: () {
            LocalDatabase.instance.logoutUser(
              onSuccess: () {
                Navigator.of(context).pushReplacementNamed(Paths.onBoarding);
              },
            );
          },
        ),
      ];
}

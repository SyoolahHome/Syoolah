import 'package:ditto/model/drawer_list_time_item.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

abstract class GeneralDrawerItems {
  static List<DrawerListTimeItem> drawerListTileItems(BuildContext context) => [
        DrawerListTimeItem(
          icon: FlutterRemix.information_line,
          label: 'about'.tr(),
          onTap: () {
            Navigator.of(context).pushNamed(Paths.aboutApp);
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

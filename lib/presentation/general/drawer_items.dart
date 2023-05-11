import 'package:ditto/constants/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../services/database/local/local_database.dart';
import '../../services/utils/paths.dart';
import '../about/about.dart';
import '../../model/drawer_list_time_item.dart';
import '../navigations_screen/chat_relays/global_chats.dart';

abstract class GeneralDrawerItems {
  static List<DrawerListTimeItem> drawerListTileItems(BuildContext context) => [
        DrawerListTimeItem(
          icon: FlutterRemix.home_4_line,
          label: 'Home',
          onTap: () {},
        ),
        DrawerListTimeItem(
          icon: FlutterRemix.user_line,
          label: 'Profile',
          onTap: () {},
        ),
        DrawerListTimeItem(
          icon: FlutterRemix.settings_line,
          label: 'Settings',
          onTap: () {
            Navigator.of(context).pushNamed(
              Paths.settings,
            );
          },
        ),
        DrawerListTimeItem(
          icon: FlutterRemix.information_line,
          label: 'About',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const About(),
              ),
            );
          },
        ),
        DrawerListTimeItem(
          icon: FlutterRemix.logout_box_line,
          label: "logout".tr(),
          isLogout: true,
          onTap: () {
            LocalDatabase.instance.logoutUser(onSuccess: () {
              Navigator.of(context).pushReplacementNamed(Paths.onBoarding);
            });
          },
        ),
      ];
}

import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../services/utils/paths.dart';
import '../about/about.dart';
import '../../model/drawer_list_time_item.dart';
import '../navigations_screen/chat_relays/global_chats.dart';

abstract class GeneralDrawerItems {
  static List<DrawerListTimeItem> drawerListTileItems(BuildContext context) => [
        DrawerListTimeItem(
          icon: FlutterRemix.home_4_line,
          label: 'Following',
          onTap: () {
            Navigator.pop(context);
          },
        ),
        DrawerListTimeItem(
          icon: FlutterRemix.chat_2_line,
          label: 'Messages',
          onTap: () {},
        ),
        DrawerListTimeItem(
          icon: FlutterRemix.camera_lens_line,
          label: 'Global',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GlobalChatRelays(),
              ),
            );
          },
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
      ];
}

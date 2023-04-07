import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../model/bottom_bat_item.dart';
import '../navigations_screen/chat_relays/global_chats.dart';
import '../navigations_screen/home/home.dart';
import '../navigations_screen/messages/Messages.dart';
import '../navigations_screen/profile/profile.dart';

abstract class GeneralBottomBar {
  static const List<BottomBarItem> items = <BottomBarItem>[
    BottomBarItem(
      screen: Home(),
      label: 'Home',
      icon: FlutterRemix.home_4_line,
    ),
    BottomBarItem(
      screen: Scaffold(),
      label: 'Messages',
      icon: FlutterRemix.message_3_line,
    ),
    BottomBarItem(
      screen: SizedBox(),
      label: 'Add New Post',
      icon: FlutterRemix.add_line,
    ),
    BottomBarItem(
      screen: GlobalChatRelays(),
      label: 'Global',
      icon: FlutterRemix.list_check_2,
    ),
    BottomBarItem(
      screen: Profile(),
      label: 'Profile',
      icon: FlutterRemix.user_line,
    ),
  ];
}

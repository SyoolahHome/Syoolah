import 'package:flutter_remix/flutter_remix.dart';

import '../../model/bottom_bat_item.dart';
import '../navigations_screen/chat_relays/global_chats.dart';
import '../navigations_screen/home/home.dart';
import '../navigations_screen/messages/Messages.dart';
import '../navigations_screen/profile/profile.dart';

abstract class GeneralBottomBar {
   static final List<BottomBarItem> items = [
    const BottomBarItem(
      screen: Home(),
      label: 'Home',
      icon: FlutterRemix.home_4_line,
    ),
    const BottomBarItem(
      screen: Messages(),
      label: 'Messages',
      icon: FlutterRemix.message_3_line,
    ),
    // BottomBarItem(
    //   screen: AddNewPost(),
    //   label: 'Add New Post',
    //   icon: Icons.add,
    // ),
    const BottomBarItem(
      screen: GlobalChatRelays(),
      label: 'Global',
      icon: FlutterRemix.list_check_2,
    ),
    const BottomBarItem(
      screen: Profile(),
      label: 'Profile',
      icon: FlutterRemix.user_line,
    ),
  ];
}
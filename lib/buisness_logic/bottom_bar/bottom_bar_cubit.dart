import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../model/bottom_bar_item.dart';
import '../../presentation/chat/chat.dart';
import '../../presentation/navigations_screen/chat_relays/global_chats.dart';
import '../../presentation/navigations_screen/home/home.dart';
import '../../presentation/navigations_screen/profile/profile.dart';

class BottomBarCubit extends Cubit<int> {
  final List<BottomBarItem> items = const <BottomBarItem>[
    BottomBarItem(
      screen: Home(),
      label: 'Home',
      icon: FlutterRemix.home_4_line,
      selectedIcon: FlutterRemix.home_4_fill,
    ),
    BottomBarItem(
      screen: Chat(),
      label: 'Chat',
      icon: FlutterRemix.message_3_line,
      selectedIcon: FlutterRemix.message_3_fill,
    ),
    BottomBarItem(
      screen: SizedBox(),
      label: 'New',
      icon: FlutterRemix.add_line,
      selectedIcon: FlutterRemix.add_fill,
    ),
    BottomBarItem(
      screen: GlobalChatRelays(),
      label: 'Global',
      icon: FlutterRemix.list_check_2,
      selectedIcon: FlutterRemix.list_check,
    ),
    BottomBarItem(
      screen: Profile(),
      label: 'Profile',
      icon: FlutterRemix.user_line,
      selectedIcon: FlutterRemix.user_fill,
    ),
  ];
  BottomBarCubit() : super(0);

  void onItemTapped(int index) {
    emit(index);
  }
}

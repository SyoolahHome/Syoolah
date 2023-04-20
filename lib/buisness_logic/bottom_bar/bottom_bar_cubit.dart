import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../model/bottom_bat_item.dart';
import '../../presentation/navigations_screen/chat_relays/global_chats.dart';
import '../../presentation/navigations_screen/home/home.dart';
import '../../presentation/navigations_screen/profile/profile.dart';

part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<int> {
  BottomBarCubit() : super(0);

  final List<BottomBarItem> items = const <BottomBarItem>[
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

  void onItemTapped(int index) {
    emit(index);
  }
}

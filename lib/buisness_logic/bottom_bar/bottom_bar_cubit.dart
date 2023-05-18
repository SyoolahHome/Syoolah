import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../model/bottom_bar_item.dart';
import '../../presentation/chat/chat.dart';
import '../../presentation/chat_modules/chat_modules.dart';
import '../../presentation/navigations_screen/chat_relays/global_chats.dart';
import '../../presentation/navigations_screen/home/home.dart';
import '../../presentation/navigations_screen/profile/profile.dart';

class BottomBarCubit extends Cubit<int> {
  final List<BottomBarItem> items = <BottomBarItem>[
    BottomBarItem(
      screen: Home(),
      label: 'home'.tr(),
      icon: FlutterRemix.home_4_line,
      selectedIcon: FlutterRemix.home_4_fill,
    ),
    BottomBarItem(
      screen: ChatModules(),
      label: 'chat'.tr(),
      icon: FlutterRemix.message_3_line,
      selectedIcon: FlutterRemix.message_3_fill,
    ),
    BottomBarItem(
      screen: SizedBox(),
      label: 'new'.tr(),
      icon: FlutterRemix.add_line,
      selectedIcon: FlutterRemix.add_fill,
    ),
    BottomBarItem(
      screen: GlobalChatRelays(),
      label: 'global'.tr(),
      icon: FlutterRemix.list_check_2,
      selectedIcon: FlutterRemix.list_check,
    ),
    BottomBarItem(
      screen: Profile(),
      label: 'profile'.tr(),
      icon: FlutterRemix.user_line,
      selectedIcon: FlutterRemix.user_fill,
    ),
  ];
  BottomBarCubit() : super(0);

  void onItemTapped(int index) {
    emit(index);
  }
}

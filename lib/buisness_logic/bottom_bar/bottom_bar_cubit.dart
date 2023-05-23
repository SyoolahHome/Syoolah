import 'package:bloc/bloc.dart';
import 'package:ditto/model/bottom_bar_item.dart';
import 'package:ditto/presentation/chat_modules/chat_modules.dart';
import 'package:ditto/presentation/feeds/global_feed.dart';
import 'package:ditto/presentation/navigations_screen/chat_relays/global_chats.dart';
import 'package:ditto/presentation/navigations_screen/home/home.dart';
import 'package:ditto/presentation/navigations_screen/profile/profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class BottomBarCubit extends Cubit<int> {
  final List<BottomBarItem> items = <BottomBarItem>[
    BottomBarItem(
      screen: Umah(),
      // const Home(),
      label: 'umah'.tr(),
      icon: FlutterRemix.home_4_line,
      selectedIcon: FlutterRemix.home_4_fill,
    ),
    BottomBarItem(
      screen: const ChatModules(),
      label: 'chat'.tr(),
      icon: FlutterRemix.message_3_line,
      selectedIcon: FlutterRemix.message_3_fill,
    ),
    // BottomBarItem(
    //   screen: const SizedBox(),
    //   label: 'new'.tr(),
    //   icon: FlutterRemix.wallet_line,
    //   selectedIcon: FlutterRemix.wallet_fill,
    // ),
    BottomBarItem(
      screen: const GlobalChatRelays(),
      label: 'global'.tr(),
      icon: FlutterRemix.list_check_2,
      selectedIcon: FlutterRemix.list_check,
    ),
    BottomBarItem(
      screen: const Profile(),
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

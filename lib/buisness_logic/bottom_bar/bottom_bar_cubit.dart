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
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class BottomBarCubit extends Cubit<int> {
  List<BottomBarItem> get items => <BottomBarItem>[
        BottomBarItem(
          screen: const Home(),
          label: 'home'.tr(),
          icon: FlutterRemix.home_4_line,
          selectedIcon: FlutterRemix.home_4_fill,
        ),
        BottomBarItem(
          screen: const ChatModules(),
          label: 'imam'.tr(),
          icon: FlutterRemix.message_3_line,
          selectedIcon: FlutterRemix.message_3_fill,
        ),
        BottomBarItem(
          screen: Umah(),
          // const Home(),
          label: 'umah'.tr(),
          icon: FlutterIslamicIcons.community,
          selectedIcon: FlutterIslamicIcons.solidCommunity,
        ),

        // BottomBarItem(
        //   screen: const Profile(),
        //   label: 'profile'.tr(),
        //   icon: FlutterRemix.user_line,
        //   selectedIcon: FlutterRemix.user_fill,
        // ),

        BottomBarItem(
          screen: const Scaffold(backgroundColor: Colors.grey),
          label: 'wallet'.tr(),
          icon: FlutterRemix.wallet_line,
          selectedIcon: FlutterRemix.wallet_fill,
        ),
      ];

  BottomBarCubit() : super(2);

  void onItemTapped(int index) {
    emit(index);
  }
}

import 'package:bloc/bloc.dart';
import 'package:ditto/model/bottom_bar_item.dart';
import 'package:ditto/presentation/chat_modules/chat_modules.dart';
import 'package:ditto/presentation/feeds/global_feed.dart';
import 'package:ditto/presentation/navigations_screen/home/home.dart';
import 'package:ditto/presentation/navigations_screen/profile/profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

import '../../presentation/dms/dms.dart';

class BottomBarCubit extends Cubit<int> {
  bool _shouldShowLeadingOnProfile = false;
  bool get shouldShowLeadingOnProfile => _shouldShowLeadingOnProfile;

  List<BottomBarItem> get items => <BottomBarItem>[
        BottomBarItem(
          screen: const Home(),
          label: 'home'.tr(),
          icon: FlutterRemix.home_4_line,
          selectedIcon: FlutterRemix.home_4_fill,
        ),
        BottomBarItem(
          screen: const Profile(),
          label: 'profile'.tr(),
          icon: FlutterRemix.user_line,
          selectedIcon: FlutterRemix.user_fill,
        ),
        BottomBarItem(
          screen: const ChatModules(),
          label: 'imam'.tr(),
          icon: FlutterIslamicIcons.quran,
          selectedIcon: FlutterIslamicIcons.solidQuran,
        ),
        BottomBarItem(
          screen: Umah(),
          // const Home(),
          label: 'umaxh'.tr(),
          icon: FlutterIslamicIcons.community,
          selectedIcon: FlutterIslamicIcons.solidCommunity,
        ),
        BottomBarItem(
          screen: const DMS(),
          label: 'dms'.tr(),
          icon: FlutterRemix.discuss_line,
          selectedIcon: FlutterRemix.discuss_fill,
        ),
      ];

  List<BottomBarItem> get itemsToShowInBottomBarScreen =>
      items.take(items.length - 1).toList();

  BottomBarCubit() : super(0) {
    final indexOfProfile = items.indexWhere(
      (element) => element.screen is Umah,
    );
    emit(indexOfProfile);
  }

  void onItemTapped(
    int index, {
    bool shouldShowLeadingOnProfile = false,
  }) {
    _shouldShowLeadingOnProfile = shouldShowLeadingOnProfile;
    emit(index);
  }
}

import 'package:ditto/model/tab_item.dart';
import 'package:ditto/presentation/current_user_reposts/current_user_reposts.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/current_user_likes.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/current_user_posts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

abstract class GeneralProfileTabs {
  static List<TabItem> profileTabsItems = [
    TabItem(
      label: "posts".tr(),
      widget: const CurrentUserPosts(),
      icon: FlutterRemix.line_height,
    ),
    TabItem(
      label: "reposts".tr(),
      widget: const CurrentUserReposts(),
      icon: FlutterRemix.repeat_2_line,
    ),
    TabItem(
      label: "likes".tr(),
      widget: const Center(
        child: CurrentUserLikes(),
      ),
      icon: FlutterRemix.heart_3_line,
    ),
  ];
}

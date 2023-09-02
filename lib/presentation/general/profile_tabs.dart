import 'package:ditto/model/tab_item.dart';
import 'package:ditto/presentation/current_user_reposts/current_user_reposts.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/current_user_likes.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/current_user_posts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../navigations_screen/profile/widgets/current_user_comments.dart';

abstract class GeneralProfileTabs {
  static List<TabItem> profileTabsItems({
    required String userPubKey,
  }) =>
      [
        TabItem(
          label: "notes".tr(),
          widget: CurrentUserPosts(
            userPubKey: userPubKey,
          ),
          icon: FlutterRemix.line_height,
        ),
        TabItem(
          label: "takes".tr(),
          widget: CurrentUserReposts(
            userPubKey: userPubKey,
          ),
          icon: FlutterRemix.repeat_2_line,
        ),
        TabItem(
          label: "likes".tr(),
          widget: Center(
            child: CurrentUserLikes(
              userPubKey: userPubKey,
            ),
          ),
          icon: FlutterRemix.heart_3_line,
        ),
        TabItem(
          label: "comments".tr(),
          widget: Center(
            child: CurrentUserComments(
              userPubKey: userPubKey,
            ),
          ),
          icon: FlutterRemix.message_line,
        ),
      ];
}

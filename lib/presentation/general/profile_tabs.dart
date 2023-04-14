import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../constants/strings.dart';
import '../../model/tab_item.dart';
import '../navigations_screen/profile/widgets/current_user_likes.dart';
import '../navigations_screen/profile/widgets/current_user_posts.dart';

abstract class GeneralProfileTabs {
  static const List<TabItem> profileTabsItems = [
    TabItem(
      label: AppStrings.posts,
      widget: CurrentUserPosts(),
      icon: FlutterRemix.line_height,
    ),
    TabItem(
      label: AppStrings.reposts,
      widget: Center(
        child: Text("reposts"),
      ),
      icon: FlutterRemix.repeat_2_line,
    ),
    TabItem(
      label: AppStrings.likes,
      widget: Center(
        child: CurrentUserLikes(),
      ),
      icon: FlutterRemix.heart_3_line,
    ),
  ];
}

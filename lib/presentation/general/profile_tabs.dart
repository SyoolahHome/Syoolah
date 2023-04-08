import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/tab_item.dart';
import '../navigations_screen/profile/widgets/current_user_likes.dart';
import '../navigations_screen/profile/widgets/current_user_posts.dart';

abstract class GeneralProfileTabs {
  static const List<TabItem> profileTabsItems = [
    TabItem(
      label: "Posts",
      widget: CurrentUserPosts(),
    ),
    TabItem(
      label: "reposts",
      widget: Center(
        child: Text("reposts"),
      ),
    ),
    TabItem(
      label: "Likes",
      widget: Center(
        child: CurrentUserLikes(),
      ),
    ),
  ];
}

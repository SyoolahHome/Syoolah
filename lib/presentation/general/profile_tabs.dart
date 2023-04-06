import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/tab_item.dart';
import '../navigations_screen/profile/widgets/current_user_posts.dart';

abstract class GeneralProfileTabs {
  static const List<TabItem> profileTabsItems = [
    TabItem(
      label: "Posts",
      widget: CurrentUserPosts(),
    ),
    TabItem(
      label: "Replies",
      widget: Center(
        child: Text("Replies"),
      ),
    ),
    TabItem(
      label: "Likes",
      widget: Center(
        child: Text("Likes"),
      ),
    ),
  ];
}

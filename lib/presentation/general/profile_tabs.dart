import 'package:flutter/material.dart';

import '../../model/tab_item.dart';

abstract class GeneralProfileTabs {
  static const List<TabItem> profileTabsItems = [
    TabItem(
      label: "Posts",
      widget: Center(
        child: Text("Posts"),
      ),
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

import 'package:flutter/material.dart';

import '../../../constants/strings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.feedName,
  });

  final String feedName;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppStrings.feedOfName(feedName)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

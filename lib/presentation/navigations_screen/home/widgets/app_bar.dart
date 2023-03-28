import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../constants/colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: AppColors.white,
        size: 20,
      ),
      backgroundColor: AppColors.teal,
      leading: IconButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        icon: const Icon(FlutterRemix.menu_line),
      ),
      actions: const <Widget>[
        Icon(FlutterRemix.search_2_line),
        SizedBox(width: 20),
        Icon(FlutterRemix.heart_2_line),
        SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

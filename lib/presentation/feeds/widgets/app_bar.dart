import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/colors.dart';
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
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
          FlutterRemix.arrow_left_fill,
          color: AppColors.black,
          size: 20,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            FlutterRemix.search_2_line,
            color: AppColors.black,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

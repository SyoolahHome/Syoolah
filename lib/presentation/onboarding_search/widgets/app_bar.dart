import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppStrings.searchUsers,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.white,
            ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          FlutterRemix.arrow_left_line,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

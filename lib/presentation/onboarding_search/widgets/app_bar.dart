import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("searchUser".tr(),
          style: Theme.of(context).textTheme.labelLarge),
      backgroundColor: AppColors.lighGrey,
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

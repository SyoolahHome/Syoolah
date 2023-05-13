import 'package:ditto/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../services/utils/paths.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        "editProfile".tr(),
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.white,
            ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(FlutterRemix.key_2_line),
          onPressed: () {
            Navigator.of(context).pushNamed(Paths.myKeys);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

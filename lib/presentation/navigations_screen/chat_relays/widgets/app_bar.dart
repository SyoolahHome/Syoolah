import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("globalMessages".tr()),
      backgroundColor: AppColors.teal,
      centerTitle: true,
      leading: InkWell(
        child: const Icon(FlutterRemix.arrow_left_line),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

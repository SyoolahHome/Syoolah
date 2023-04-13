import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/strings.dart';
import '../../../general/widget/title.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const HeadTitle(
        title: AppStrings.myProfile,
      ),
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            FlutterRemix.more_2_line,
            color: AppColors.black,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

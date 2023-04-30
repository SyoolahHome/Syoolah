import 'package:ditto/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.teal,
      title: const Text(AppStrings.globalMessages),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

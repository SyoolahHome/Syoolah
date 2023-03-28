import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

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

import 'package:ditto/constants/colors.dart';
import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        AppStrings.editProfile,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.white,
            ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

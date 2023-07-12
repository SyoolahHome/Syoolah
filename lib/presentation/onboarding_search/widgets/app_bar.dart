import 'package:ditto/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../services/utils/app_utils.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar({
    super.key,
    super.preferredSize = const Size.fromHeight(kToolbarHeight),
    super.child = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "searchUser".tr(),
        style: Theme.of(context).textTheme.labelLarge,
      ),
      backgroundColor: AppColors.lighGrey,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          AppUtils.directionality_arrow_left_line(context),
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

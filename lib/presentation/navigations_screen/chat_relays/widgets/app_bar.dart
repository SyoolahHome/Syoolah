import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../services/utils/app_utils.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar({
    super.key,
    super.preferredSize = const Size.fromHeight(kToolbarHeight),
    super.child = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("globalMessages".tr()),
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      leading: InkWell(
        child: Icon(AppUtils.instance.directionality_arrow_left_line(context)),
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

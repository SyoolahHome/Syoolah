import 'package:ditto/presentation/onboarding/widgets/animated_logo.dart';
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
    const logoSize = 50.0;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(
          AppUtils.instance.directionality_arrow_left_line(context),
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const AppBrandLogo(width: logoSize),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

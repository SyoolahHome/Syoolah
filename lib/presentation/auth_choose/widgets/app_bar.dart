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
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const MunawarahLogo(width: 50),
      titleSpacing: 5.0,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          AppUtils.directionality_arrow_left_line(context),
          color: Theme.of(context).colorScheme.background,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

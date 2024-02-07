import 'package:ditto/presentation/onboarding/widgets/animated_logo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../services/utils/app_utils.dart';
import '../../general/widget/bottom_sheet_title_with_button.dart';
import '../../general/widget/margined_body.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar({
    super.key,
    super.preferredSize = const Size.fromHeight(kToolbarHeight),
    super.child = const SizedBox.shrink(),
    required this.isShownInBottomSheet,
  });

  final bool isShownInBottomSheet;

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    if (isShownInBottomSheet) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: height * 2),
        child: MarginedBody(
          child: BottomSheetTitleWithIconButton(
            title: "chooseAuth".tr(),
          ),
        ),
      );
    }
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const UmrahtyLogo(width: 50),
      titleSpacing: 5.0,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          AppUtils.instance.directionality_arrow_left_line(context),
          color: Theme.of(context).colorScheme.background,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

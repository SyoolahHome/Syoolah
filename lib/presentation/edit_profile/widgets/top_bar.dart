import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

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
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(AppUtils.instance.directionality_arrow_left_line(context)),
      ),
      actions: <Widget>[
        AppBrandButton(
          onTap: () {
            Navigator.of(context).pushNamed(Paths.myKeys);
          },
          isSmall: true,
          text: "keys".tr(),
          icon: FlutterRemix.key_2_line,
          iconSize: 15,
          isOnlyBorder: true,
        ),
        const SizedBox(width: 10),
        // IconButton(
        //   icon: const Icon(FlutterRemix.key_2_line),
        //   onPressed:
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

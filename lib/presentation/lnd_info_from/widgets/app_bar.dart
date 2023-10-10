import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LndInfoFromBar extends StatelessWidget with PreferredSizeWidget {
  const LndInfoFromBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "create_address_lnd".tr(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

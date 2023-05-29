import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  const CustomAppBar({
    super.key,
    super.preferredSize = const Size.fromHeight(kToolbarHeight),
    super.child = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text("globalMessages".tr()),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

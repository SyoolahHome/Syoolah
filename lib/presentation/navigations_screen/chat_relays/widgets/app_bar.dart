import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

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
        child: const Icon(FlutterRemix.arrow_left_line),
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

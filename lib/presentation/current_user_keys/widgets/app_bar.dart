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
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(FlutterRemix.arrow_left_line),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

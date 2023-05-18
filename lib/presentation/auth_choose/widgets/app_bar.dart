import 'package:ditto/presentation/onboarding/widgets/animated_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const MunawarahLogo(width: 50),
      titleSpacing: 5.0,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          FlutterRemix.arrow_left_line,
          color: Theme.of(context).colorScheme.background,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

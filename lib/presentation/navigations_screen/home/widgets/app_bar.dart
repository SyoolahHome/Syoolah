import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

import 'relays_widget.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Center(
        child: Animate(
          effects: [FadeEffect()],
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.onTertiaryContainer,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(
              FlutterRemix.menu_line,
            ),
          ),
        ),
      ),
      actions: AnimateList(
        effects: [FadeEffect()],
        children: const <Widget>[
          RelaysWidget(),
          SizedBox(width: 20),
          // Icon(FlutterRemix.heart_2_line, size: 22),
          // SizedBox(width: 10),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

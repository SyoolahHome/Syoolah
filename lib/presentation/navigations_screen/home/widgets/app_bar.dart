import 'package:ditto/presentation/navigations_screen/home/widgets/relays_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

import 'profile_icon.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Center(
        child: Animate(
          effects: const <Effect>[
            FadeEffect(),
          ],
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
        interval: 100.ms,
        effects: <Effect>[
          const FadeEffect(),
        ],
        children: const <Widget>[
          RelaysWidget(),
          SizedBox(width: 2.5),
          ProfileIcon(),
          SizedBox(width: 2.5),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

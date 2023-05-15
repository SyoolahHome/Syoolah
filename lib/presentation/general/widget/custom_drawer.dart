import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/app_colors.dart';
import '../../../services/bottom_sheet/bottom_sheet_service.dart';
import '../../onboarding/widgets/animated_logo.dart';
import '../drawer_items.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = GeneralDrawerItems.drawerListTileItems(context);
    final theme = Theme.of(context);
    const heightSeparator = 60.0;
    const logoSize = 100.0;

    return Theme(
      data: theme.copyWith(
        highlightColor: theme.colorScheme.onPrimary,
        splashColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: Drawer(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: heightSeparator),
            Animate(
              effects: <Effect>[FadeEffect()],
              child: Container(
                  padding: MarginedBody.defaultMargin,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MunawarahLogo(width: logoSize),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(.5),
                        ),
                        onPressed: () {
                          BottomSheetService.showCreatePostBottomSheet(context);
                        },
                        icon: Icon(FlutterRemix.add_line),
                      )
                    ],
                  )),
            ),
            const SizedBox(height: heightSeparator / 2),
            Center(child: OrDivider()),
            const SizedBox(height: heightSeparator / 2),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: AnimateList(
                effects: [
                  FadeEffect(),
                  SlideEffect(begin: const Offset(-0.5, 0)),
                ],
                interval: 200.ms,
                children: items.map(
                  (currentItem) {
                    const iconSize = 23.0;
                    final isLogout = currentItem.isLogout;

                    return ListTile(
                      contentPadding: MarginedBody.defaultMargin,
                      leading: Icon(
                        currentItem.icon,
                        color: isLogout
                            ? theme.colorScheme.error
                            : theme.primaryColor,
                        size: iconSize,
                      ),
                      title: Text(
                        currentItem.label,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: isLogout ? theme.colorScheme.error : null,
                        ),
                      ),
                      onTap: currentItem.onTap,
                    );
                  },
                ).toList(),
              ),
            ),
            Spacer(),
            Animate(
              delay: 1200.ms,
              effects: <Effect>[FadeEffect()],
              child: Container(
                padding: MarginedBody.defaultMargin,
                child: Text(
                  "Munwarah App ${AppConfigs.version}",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.w300,
                      ),
                ),
              ),
            ),
            const SizedBox(height: heightSeparator / 4),
          ],
        ),
      ),
    );
  }
}

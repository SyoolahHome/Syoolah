import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0),
          ),
        ),
        backgroundColor: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: heightSeparator),
            Container(
              padding: MarginedBody.defaultMargin,
              child: Align(
                alignment: Alignment.centerLeft,
                child: MunawarahLogo(width: logoSize),
              ),
            ),
            const SizedBox(height: heightSeparator / 2),
            OrDivider(),
            const SizedBox(height: heightSeparator / 2),
            ...List.generate(
              items.length,
              (index) {
                final currentItem = items[index];
                const iconSize = 23.0;
                final isLogout = currentItem.isLogout;

                return ListTile(
                  contentPadding: MarginedBody.defaultMargin,
                  leading: Icon(
                    currentItem.icon,
                    color:
                        isLogout ? theme.colorScheme.error : theme.primaryColor,
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
            ),
            Spacer(),
            Container(
              padding: MarginedBody.defaultMargin,
              child: Text(
                "Munwarah App ${AppConfigs.version}",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.w300,
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

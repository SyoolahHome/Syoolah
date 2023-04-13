import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../model/drawer_list_tile.dart';
import '../drawer_items.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = GeneralDrawerItems.drawerListTileItems(context);

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      backgroundColor: AppColors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(height: 60),
          ...List.generate(
            items.length,
            (index) {
              final current = items[index];

              return ListTile(
                leading: Icon(current.icon, color: AppColors.teal),
                title: Text(current.label),
                onTap: current.onTap,
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// {@template drawer_list_time_item}
/// A model class that holds data related to a drawer list item.
/// {@endtemplate}
@immutable
class DrawerListTimeItem {
  /// The icon to be shown in the tile of the drawer item.
  final IconData icon;

  /// A label/name of this item
  final String label;

  /// A callback that will run when the user taps on the drawer item.
  final void Function() onTap;

  /// Weither a user is authenticated or logs out.
  final bool isLogout;

  /// {@macro drawer_list_time_item}
  const DrawerListTimeItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isLogout = false,
  });
}

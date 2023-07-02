import 'package:flutter/material.dart';

import '../constants/abstractions/abstractions.dart';

@immutable
class BottomBarItem {
  final BottomBarScreen screen;
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const BottomBarItem({
    required this.screen,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

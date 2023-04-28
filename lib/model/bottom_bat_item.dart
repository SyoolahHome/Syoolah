// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class BottomBarItem {
  final Widget screen;
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

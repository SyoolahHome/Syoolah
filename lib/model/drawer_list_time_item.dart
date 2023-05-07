// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class DrawerListTimeItem {
  final IconData icon;
  final String label;
  final void Function() onTap;
  final bool isLogout;

  const DrawerListTimeItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isLogout = false,
  });
}

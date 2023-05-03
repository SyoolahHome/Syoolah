import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsItem extends Equatable {
  final IconData icon;
  final String name;
  final Function onTap;
  final Widget? trailing;

  const SettingsItem({
    required this.icon,
    required this.name,
    required this.onTap,
    this.trailing,
  });

  @override
  List<Object?> get props => [
        icon,
        name,
        onTap,
        trailing,
      ];
}

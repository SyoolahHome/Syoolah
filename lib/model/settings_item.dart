import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// {@template setting_item}
/// A model class tat represents a setting item to be presented in the settings UI.
/// {@endtemplate}
@immutable
class SettingsItem extends Equatable {
  /// The icon to be shown for the settings item tile.
  final IconData icon;

  /// The name/title of this setting.
  final String name;

  /// THe callback to run when the user will tap on the setting tile.
  final VoidCallback onTap;

  /// The trailing to be adde to the setting tile if it eists.
  final Widget? trailing;

  /// {@macro setting_item}
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

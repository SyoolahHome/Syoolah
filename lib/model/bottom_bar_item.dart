import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../constants/abstractions/abstractions.dart';

/// {@template bottom_bar_item}
/// A model class representing an item that relates to a the bottom bar to be selected, and so it's screen is shown
/// {@endtemplate}
@immutable
class BottomBarItem extends Equatable {
  /// The [screen] to be shown that is associated to this item.
  final BottomBarScreen? screen;

  /// YjeThe name/label for this item.
  final String label;

  /// An icon to be shown in the bottom bar when this item is not selected
  final IconData icon;

  /// An icon to be shown in the bottom bar when this item is selected
  final IconData selectedIcon;

  /// an svg icon path if it exists for the current item.
  final String? svgIconPath;

  /// {@macro bottom_bar_item}
  const BottomBarItem({
    required this.screen,
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.svgIconPath,
  });

  factory BottomBarItem.withExclusiveIcon({
    required BottomBarScreen screen,
    required String label,
    required IconData exclusiveIcon,
    String? svgIconPath,
  }) {
    return BottomBarItem(
      screen: screen,
      label: label,
      icon: exclusiveIcon,
      selectedIcon: exclusiveIcon,
      svgIconPath: svgIconPath,
    );
  }

  @override
  List<Object?> get props => [
        screen,
        label,
        icon,
        selectedIcon,
        svgIconPath,
      ];
}

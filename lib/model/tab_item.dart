import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

/// {@template tab_item}
/// A model class that represents data relted to a tabItem to be used with a [Tab] & [TabBarView].
/// {@endtemplate}
class TabItem extends Equatable {
  /// The widget associated with this tab to be shown.
  final Widget widget;

  /// THe label of this tab to be shown in the [Tab].
  final String label;

  /// The icon to be represented in the [Tab].
  final IconData icon;

  @override
  List<Object?> get props => [
        widget,
        label,
        icon,
      ];

  /// {@macro tab_item}
  const TabItem({
    required this.widget,
    required this.label,
    required this.icon,
  });
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../constants/abstractions/abstractions.dart';

/// {template post_asset_section_item}
/// Represents an model that holds data about a post asset option that will we shown while adding new notes by users
/// {@endtemplate}
@immutable
class PostAssetSectionItem extends Equatable {
  /// An icon to be shown for the post asset section.
  final IconData icon;

  /// The widget to switched to when this is tapped.
  final NewPostAssetWidget widget;

  /// {@macro post_asset_section_item}
  const PostAssetSectionItem({
    required this.icon,
    required this.widget,
  });

  /// {@macro post_asset_section_item}
  /// This ignores the tap handler [onPressed].
  factory PostAssetSectionItem.withoutTapHandler({
    required IconData icon,
    required NewPostAssetWidget widget,
  }) {
    return PostAssetSectionItem(
      icon: icon,
      widget: widget,
    );
  }
  @override
  List<Object?> get props => [icon, widget];
}

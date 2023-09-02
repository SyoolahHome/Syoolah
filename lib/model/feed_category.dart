import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../constants/app_enums.dart';

/// {@template feed_category}
/// A model class that represents a category of M feeds.
/// {@endtemplate}
@immutable
class FeedCategory extends Equatable {
  /// Th name of the feed to be shown.
  final String name;

  /// The route path to be navigated to when the user taps on the box that represents the feed category.
  final String path;

  /// The description to be shown for this feed category.
  final String description;

  /// Weither this feed is selected or not by the user.
  final bool isSelected;

  /// An icon that will be shown in the box representing the feed category.
  final IconData icon;

  /// An enum that represents the topic/category of this feed.
  final SakhirTopics enumValue;

  @override
  List<Object?> get props => [
        name,
        isSelected,
        description,
        icon,
        path,
        enumValue,
      ];

  /// {@macro feed_category}
  const FeedCategory({
    required this.name,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.path,
    required this.enumValue,
  });

  /// returns a new [FeedCategory], with [isSelected] field set to [value].
  FeedCategory toggleSelected(bool value) {
    return copyWith(isSelected: value);
  }

  /// {@macro feed_category}
  FeedCategory copyWith({
    String? name,
    String? description,
    bool? isSelected,
    IconData? icon,
    String? path,
    SakhirTopics? enumValue,
  }) {
    return FeedCategory(
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
      path: path ?? this.path,
      enumValue: enumValue ?? this.enumValue,
    );
  }
}

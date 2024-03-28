import 'package:dart_nostr/dart_nostr.dart';
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

  // /// The route path to be navigated to when the user taps on the box that represents the feed category.
  // final String path;

  // /// The description to be shown for this feed category.
  // final String description;

  /// Weither this feed is selected or not by the user.
  final bool isSelected;

  // /// An icon that will be shown in the box representing the feed category.
  // final IconData icon;

  /// An enum that represents the topic/category of this feed.
  final AppBrandTopics enumValue;

  /// the nostr events stream for the feed.
  final NostrEventsStream feedPostsStream;

  @override
  List<Object?> get props => [name, isSelected, enumValue];

  /// {@macro feed_category}
  const FeedCategory({
    required this.name,
    // required this.icon,
    required this.isSelected,
    required this.enumValue,
    required this.feedPostsStream,
  });

  /// returns a new [FeedCategory], with [isSelected] field set to [value].
  FeedCategory toggleSelected(bool value) {
    return copyWith(isSelected: value);
  }

  /// {@macro feed_category}
  FeedCategory copyWith({
    String? name,
    bool? isSelected,
    AppBrandTopics? enumValue,
    NostrEventsStream? feedPostsStream,
    String? imageIcon,
  }) {
    return FeedCategory(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
      enumValue: enumValue ?? this.enumValue,
      feedPostsStream: feedPostsStream ?? this.feedPostsStream,
    );
  }
}

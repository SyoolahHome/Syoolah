import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../constants/app_configs.dart';
import '../constants/app_enums.dart';

class FeedCategory extends Equatable {
  final String name;
  final String path;
  final String description;
  final bool isSelected;
  final IconData icon;
  final MunawarahTopics enumValue;
  @override
  List<Object?> get props => [
        name,
        isSelected,
        description,
        icon,
        path,
        enumValue,
      ];

  const FeedCategory({
    required this.name,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.path,
    required this.enumValue,
  });

  FeedCategory toggleSelected(bool value) {
    return FeedCategory(
      name: this.name,
      description: this.description,
      icon: this.icon,
      isSelected: value,
      path: this.path,
      enumValue: this.enumValue,
    );
  }

  FeedCategory copyWith({
    String? name,
    String? description,
    bool? isSelected,
    IconData? icon,
    String? path,
    MunawarahTopics? enumValue,
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

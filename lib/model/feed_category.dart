// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FeedCategory extends Equatable {
  final String name;
  final String path;
  final String description;
  final bool isSelected;
  final IconData icon;

  const FeedCategory({
    required this.name,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.path,
  });

  @override
  List<Object?> get props => [
        name,
        isSelected,
        description,
        icon,
        path,
      ];

  FeedCategory copyWith({
    String? name,
    String? description,
    bool? isSelected,
    IconData? icon,
    String? path,
  }) {
    return FeedCategory(
      path: path ?? this.path,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

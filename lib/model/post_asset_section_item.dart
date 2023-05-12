import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PostAssetSectionItem extends Equatable {
  final IconData icon;

  final VoidCallback onPressed;

  final Widget widget;

  const PostAssetSectionItem({
    required this.icon,
    required this.onPressed,
    required this.widget,
  });

  @override
  List<Object?> get props => [icon, onPressed, widget];
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class TabItem extends Equatable {
  final Widget widget;
  final String label;
  final IconData icon;

  @override
  List<Object?> get props => [
        widget,
        label,
        icon,
      ];

  const TabItem({
    required this.widget,
    required this.label,
    required this.icon,
  });
}

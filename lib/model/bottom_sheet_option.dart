import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BottomSheetOption extends Equatable {
  final String title;
  final IconData icon;
  final String? successMessage;
  final String? errorMessage;
  final Widget? trailing;
  final void Function()? onPressed;

  @override
  List<Object?> get props => [
        title,
        icon,
        onPressed,
        successMessage,
        errorMessage,
        trailing,
      ];

  const BottomSheetOption({
    required this.title,
    required this.icon,
    this.onPressed,
    this.successMessage,
    this.trailing,
    this.errorMessage,
  });
}

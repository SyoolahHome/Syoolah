import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProfileOption extends Equatable {
  final String title;
  final IconData icon;
  final String? successMessage;
  final String? errorMessage;

  final void Function() onPressed;

  const ProfileOption({
    required this.title,
    required this.icon,
    required this.onPressed,
    this.successMessage,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        title,
        icon,
        onPressed,
        successMessage,
        errorMessage,
      ];
}

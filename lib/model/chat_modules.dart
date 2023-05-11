import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChatModuleItem extends Equatable {
  final String title;
  final String subtitle;
  final IconData icon;
  final String instruction;
  final List<String> recommendedQuestions;

  const ChatModuleItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.instruction,
    required this.recommendedQuestions,
  });

  @override
  List<Object?> get props => [
        title,
        subtitle,
        icon,
        instruction,
        recommendedQuestions,
      ];
}

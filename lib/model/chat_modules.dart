import 'package:dart_openai/openai.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// {@template chat_module_item}
/// A model class representing one single Imam chat module to presented as an Imam level for the end user.
/// {@endtemplate}
class ChatModuleItem extends Equatable {
  /// The title of the chat module
  final String title;

  /// A description for this chat module.
  final String subtitle;

  /// An isonc for this chat modeule.
  final IconData icon;

  /// An AI instruction that used to instruct the IMma initialy, basically to be used as a [OpenAIChatMessageRole.assistant] or [OpenAIChatMessageRole.system] on low level API to [dart_openai] package.
  final String instruction;

  /// A list containing recommended question to be shown randomly or in an order way for the user as recommendations to start the chat experience.
  final List<String> recommendedQuestions;

  /// {@macro chat_module_item}
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

  /// {@macro chat_module_item}
  /// This specifically represent an beginner level Imam.
  factory ChatModuleItem.beginner({
    required IconData icon,
    required String instruction,
    required List<String> recommendedQuestions,
    required String subtitle,
  }) {
    return ChatModuleItem(
      title: "Beginner",
      icon: icon,
      instruction: instruction,
      recommendedQuestions: recommendedQuestions,
      subtitle: subtitle,
    );
  }

  /// {@macro chat_module_item}
  /// This specifically represent an intermediate level Imam.
  factory ChatModuleItem.intermediate({
    required IconData icon,
    required String instruction,
    required List<String> recommendedQuestions,
    required String subtitle,
  }) {
    return ChatModuleItem(
      title: 'Intermediate' /* ?? "chatInstructorTitle".tr() */,
      icon: icon,
      instruction: instruction,
      recommendedQuestions: recommendedQuestions,
      subtitle: subtitle,
    );
  }

  /// {@macro chat_module_item}
  /// This specifically represent an advanced level Imam.
  factory ChatModuleItem.advanced({
    required IconData icon,
    required String instruction,
    required List<String> recommendedQuestions,
    required String subtitle,
  }) {
    return ChatModuleItem(
      title: "Advanced" /* ?? "chatInstructorTitle".tr() */,
      icon: icon,
      instruction: instruction,
      recommendedQuestions: recommendedQuestions,
      subtitle: subtitle,
    );
  }
}

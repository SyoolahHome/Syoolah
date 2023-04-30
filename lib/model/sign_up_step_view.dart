import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SignUpStepView extends Equatable {
  final String title;
  final String subtitle;
  final Widget widgetBody;
  final bool Function() nextViewAllower;
  final void Function()? onButtonTap;

  @override
  List<Object?> get props => [
        title,
        onButtonTap,
        subtitle,
        widgetBody,
        nextViewAllower,
      ];

  const SignUpStepView({
    required this.title,
    required this.subtitle,
    required this.widgetBody,
    required this.nextViewAllower,
    this.onButtonTap,
  });
}

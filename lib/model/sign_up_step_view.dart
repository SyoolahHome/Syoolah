import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../constants/app_enums.dart';
import '../presentation/general/text_field.dart';
import '../presentation/private_succes/widgets/key_section.dart';

class SignUpStepView extends Equatable {
  final String title;
  final String subtitle;
  final Widget widgetBody;
  final Future<bool> Function() nextViewAllower;
  final void Function()? onButtonTap;
  final String? errorText;
  @override
  List<Object?> get props => [
        title,
        onButtonTap,
        subtitle,
        widgetBody,
        nextViewAllower,
        errorText,
      ];

  const SignUpStepView({
    required this.title,
    required this.subtitle,
    required this.widgetBody,
    required this.nextViewAllower,
    this.onButtonTap,
    this.errorText,
  });

  factory SignUpStepView.keyShowcase({
    required String title,
    required String subtitle,
    required Future<bool> Function() nextViewAllower,
    required KeySectionType keyType,
  }) {
    return SignUpStepView(
      title: title,
      subtitle: subtitle,
      widgetBody: KeySection(type: keyType),
      nextViewAllower: nextViewAllower,
    );
  }

  factory SignUpStepView.withOnlyTextField({
    required String title,
    required String subtitle,
    required TextEditingController? controller,
    required String hint,
    required Future<bool> Function() nextViewAllower,
    void Function()? onButtonTap,
  }) {
    return SignUpStepView(
      title: title,
      subtitle: subtitle,
      widgetBody: CustomTextField(
        showClearButton: true,
        controller: controller,
        hint: hint,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      ),
      nextViewAllower: nextViewAllower,
      onButtonTap: onButtonTap,
    );
  }
}

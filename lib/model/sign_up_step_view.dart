import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../constants/app_enums.dart';
import '../presentation/general/text_field.dart';
import '../presentation/private_succes/widgets/key_section.dart';

/// {@template sign_up_step_view}
/// A model class that represents a sign up step view to be represnted in the sign up flow UI.
/// {@endtemplate}
@immutable
class SignUpStepView extends Equatable {
  /// The title of the step.
  final String title;

  /// The subtitle of the step.
  final String subtitle;

  /// The widget body to be shown in the center of the step UI.
  final Widget widgetBody;

  /// A callback future to determine weither to allow this step to pass to the next or no.
  final Future<bool> Function() nextViewAllower;

  /// A callback that will run additionally to the steps main button, if it exists.
  final void Function()? onButtonTap;

  /// An error text to be represented in the UI if it exists.
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

  /// {@macro sign_up_step_view}
  const SignUpStepView({
    required this.title,
    required this.subtitle,
    required this.widgetBody,
    required this.nextViewAllower,
    this.onButtonTap,
    this.errorText,
  });

  /// {@macro sign_up_step_view}
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

  /// {@macro sign_up_step_view}
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

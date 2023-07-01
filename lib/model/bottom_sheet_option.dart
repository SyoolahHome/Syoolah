import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../presentation/general/widget/button.dart';
import 'loclal_item.dart';

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
  factory BottomSheetOption.translationOption({
    required LocaleItem localeItem,
    required bool isCurrentApplied,
    required void Function() onTap,
    IconData icon = FlutterRemix.arrow_right_line,
  }) {
    return BottomSheetOption(
      title: localeItem.titleName,
      icon: icon,
      trailing: MunawarahButton.bottomSheetApply(
        buttonText: localeItem.applyText,
        locale: localeItem.locale,
        onTap: () {
          onTap();
        },
        isCurrentApplied: isCurrentApplied,
      ),
    );
  }
}

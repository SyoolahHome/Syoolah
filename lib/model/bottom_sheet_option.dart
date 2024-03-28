import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../presentation/general/widget/button.dart';
import 'loclal_item.dart';

/// {@template bottom_sheet_option}
/// A model holding data related to one bottom sheet to be shown as a standalone option.
/// {@endtemplate}
class BottomSheetOption extends Equatable {
  /// The title to be shown, like an order/description of the option.
  final String title;

  /// The icon to be shown in the leading of the option tile.
  final IconData icon;

  /// The callback of the option when it is clicked by the user.
  final VoidCallback? onPressed;

  /// The message to be used when the [onPressed] is resolved succesfully.
  final String? successMessage;

  /// The message to be shown when the [onPressed] is resolved with an error.
  final String? errorMessage;

  /// The trailing of the bottom sheet option if it exists.
  final Widget? trailing;

  @override
  List<Object?> get props => [
        title,
        icon,
        onPressed,
        successMessage,
        errorMessage,
        trailing,
      ];

  /// {@macro bottom_sheet_option}
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
      trailing: RoundaboutButton.bottomSheetSwitch(
        locale: localeItem.locale,
        onTap: () {
          onTap();
        },
        isCurrentApplied: isCurrentApplied,
      ),
    );
  }
}

import 'package:ditto/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

abstract class SnackBars {
  static ScaffoldFeatureController text(
    BuildContext context,
    String message, {
    bool isError = true,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError
            ? Theme.of(context).colorScheme.errorContainer
            : Theme.of(context).colorScheme.background,
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        action: SnackBarAction(
          label: AppStrings.ok.toUpperCase(),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}

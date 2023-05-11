import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

abstract class SnackBars {
  static ScaffoldFeatureController text(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            isError ? Theme.of(context).colorScheme.errorContainer : null,
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        action: SnackBarAction(
          disabledTextColor: Theme.of(context).snackBarTheme.actionTextColor,
          label: "ok".tr().toUpperCase(),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}

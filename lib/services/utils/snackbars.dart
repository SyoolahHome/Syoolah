import 'package:flutter/material.dart';

abstract class SnackBars {
  static ScaffoldFeatureController text(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

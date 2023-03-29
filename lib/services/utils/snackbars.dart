import 'package:flutter/material.dart';

abstract class SnackBars {
  static void text(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

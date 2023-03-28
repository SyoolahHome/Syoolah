import 'package:flutter/material.dart';

abstract class AppUtils {
  static void displaySnackBar(BuildContext context, String content) {
    SnackBar snackBar = SnackBar(
      content: Text(content),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

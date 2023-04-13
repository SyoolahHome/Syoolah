import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AppUtils {
  static void displaySnackBar(BuildContext context, String content) {
    SnackBar snackBar = SnackBar(
      content: Text(content),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<void> copy(
    String text, {
    void Function()? onSuccess,
    void Function()? onError,
    void Function()? onEnd,
  }) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      onSuccess?.call();
    } catch (e) {
      onError?.call();
    } finally {
      onEnd?.call();
    }
  }
}

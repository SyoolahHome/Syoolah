import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/app_strings.dart';
import '../../../services/utils/snackbars.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.onAdd,
    required this.shouldAllowAdd,
  });

  final Future<void> Function() onAdd;
  final bool shouldAllowAdd;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: shouldAllowAdd
          ? () {
              onAdd().then((_) {
                Navigator.of(context).pop();
              }).catchError((e) {
                SnackBars.text(context, AppStrings.invalidUrl);
              });
            }
          : null,
      icon: const Icon(FlutterRemix.add_line, color: Colors.white),
      label: const Text(AppStrings.add, style: TextStyle(color: Colors.white)),
    );
  }
}

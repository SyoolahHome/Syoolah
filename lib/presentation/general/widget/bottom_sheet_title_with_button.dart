import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/app_colors.dart';

class BottomSheetTitleWithIconButton extends StatelessWidget {
  const BottomSheetTitleWithIconButton({
    super.key,
    required this.title,
    this.onPop,
  });

  final String title;
  final VoidCallback? onPop;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.background,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        IconButton(
          icon: Icon(
            FlutterRemix.close_line,
            color: Theme.of(context).colorScheme.background,
          ),
          onPressed: () {
            Navigator.pop(context);
            onPop?.call();
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/colors.dart';

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
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        IconButton(
          icon: const Icon(FlutterRemix.close_line),
          onPressed: () {
            Navigator.pop(context);
            onPop?.call();
          },
        ),
      ],
    );
  }
}

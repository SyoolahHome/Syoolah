import 'package:flutter/material.dart';

import '../../../constants/strings.dart';

class SuccessText extends StatelessWidget {
  const SuccessText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        AppStrings.keyGeneratedSuccessfullyText,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.normal,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../constants/strings.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.homeTitle,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
          ),
    );
  }
}

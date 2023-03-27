import 'package:flutter/material.dart';

import '../../../constants/strings.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      AppStrings.homeTitle,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

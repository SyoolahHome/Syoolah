import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "homeTitle".tr(),
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
          ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutSakhirTitle extends StatelessWidget {
  const AboutSakhirTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      delay: const Duration(milliseconds: 200),
      effects: const <Effect>[
        FadeEffect(),
        SlideEffect(begin: Offset(0, 0.45)),
      ],
      child: Text(
        "inAllahWeTrust".tr(),
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.background,
            ),
      ),
    );
  }
}

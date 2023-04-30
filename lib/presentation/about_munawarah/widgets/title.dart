import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';

class AboutMunawarahTitle extends StatelessWidget {
  const AboutMunawarahTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      delay: const Duration(milliseconds: 200),
      effects: const <Effect>[
        FadeEffect(),
        SlideEffect(begin: Offset(0, 0.45)),
      ],
      child: Text(
        AppStrings.aboutMunawarahWe,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.background,
            ),
      ),
    );
  }
}

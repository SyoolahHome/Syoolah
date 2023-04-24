import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants/strings.dart';

class SuccessText extends StatelessWidget {
  const SuccessText({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      delay: 200.ms,
      effects: const <Effect>[
        FadeEffect(),
        SlideEffect(begin: const Offset(0, 0.5)),
      ],
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          AppStrings.keyGeneratedSuccessfullyText,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.normal,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

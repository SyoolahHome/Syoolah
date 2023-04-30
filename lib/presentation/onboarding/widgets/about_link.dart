import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants/app_strings.dart';
import '../../../services/utils/paths.dart';

class AboutMinawarah extends StatelessWidget {
  const AboutMinawarah({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const <Effect>[
        FadeEffect(),
        SlideEffect(begin: Offset(0, 0.5)),
      ],
      delay: const Duration(milliseconds: 1000),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Paths.aboutMunawarah);
        },
        child: Center(
          child: Text(
            AppStrings.aboutMunawarah,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  // color: Theme.of(context).primaryColor,
                  decoration: TextDecoration.underline,
                ),
          ),
        ),
      ),
    );
  }
}

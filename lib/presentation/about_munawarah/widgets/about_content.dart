import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';

class AboutMunawarahContent extends StatelessWidget {
  const AboutMunawarahContent({super.key});

  @override
  Widget build(BuildContext context) {
    final contentParagraphs = AppStrings.aboutMunawarahContent.split("\n");
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        contentParagraphs.length,
        (index) {
          final current = contentParagraphs[index];

          return Animate(
            delay: Duration(milliseconds: 400 + (index * 200)),
            effects: const <Effect>[
              FadeEffect(),
              SlideEffect(begin: Offset(0, 0.45)),
            ],
            child: Text(
              current,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
          );
        },
      ),
    );
  }
}

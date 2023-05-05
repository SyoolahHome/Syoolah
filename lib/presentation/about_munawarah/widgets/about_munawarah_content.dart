import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutMunawarahContent extends StatelessWidget {
  const AboutMunawarahContent({super.key});

  @override
  Widget build(BuildContext context) {
    final contentParagraphs = "aboutMunawarahContent".tr().split("\n");

    final startingDurationMs = 400;

    Widget widget(int index) {
      final current = contentParagraphs[index];
      final labelLarge = Theme.of(context).textTheme.labelLarge;
      if (labelLarge == null) {
        throw Exception("labelLarge is null");
      }

      return Animate(
        child: Text(
          current,
          style: labelLarge.copyWith(fontWeight: FontWeight.w300),
        ),
        effects: const <Effect>[
          FadeEffect(),
          SlideEffect(begin: Offset(0, 0.45)),
        ],
        delay: Duration(
          milliseconds: startingDurationMs +
              (index * Animate.defaultDuration.inMilliseconds),
        ),
      );
    }

    ;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(contentParagraphs.length, widget),
    );
  }
}

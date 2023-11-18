import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutSakhirContent extends StatelessWidget {
  const AboutSakhirContent({super.key});

  @override
  Widget build(BuildContext context) {
    final contentParagraphs = "aboutContent".tr().split("\n");

    const startingDurationMs = 400;

    Widget widget(int index) {
      final current = contentParagraphs[index];
      final labelLarge = Theme.of(context).textTheme.labelLarge;
      if (labelLarge == null) {
        throw Exception("labelLarge is null");
      }

      return Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Animate(
          effects: const <Effect>[
            FadeEffect(),
            SlideEffect(begin: Offset(0, 0.45)),
          ],
          delay: Duration(
            milliseconds: startingDurationMs +
                (index * Animate.defaultDuration.inMilliseconds),
          ),
          child: Text(
            current,
            style: labelLarge.copyWith(fontWeight: FontWeight.w300),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(contentParagraphs.length, widget),
    );
  }
}

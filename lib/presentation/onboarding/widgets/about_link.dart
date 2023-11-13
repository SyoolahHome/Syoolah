import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutSakhir extends StatelessWidget {
  const AboutSakhir({super.key});

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
          Navigator.of(context).pushNamed(Paths.aboutSakhir);
        },
        child: Center(
          child: Text(
            "about_sakhir".tr(),
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

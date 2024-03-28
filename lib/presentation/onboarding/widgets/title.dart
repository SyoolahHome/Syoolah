import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AppBrandTitle extends StatelessWidget {
  const AppBrandTitle({
    super.key,
    this.style,
    this.animate = true,
  });

  final TextStyle? style;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final hero = Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme
          ..apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
      ),
      child: Hero(
        tag: "${"appName".tr()} title",
        child: Text(
          "appName".tr(),
          style: style ??
              Theme.of(context).textTheme.headlineLarge?.copyWith(
                    // color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
        ),
      ),
    );
    if (animate) {
      return Animate(
        delay: const Duration(milliseconds: 400),
        effects: const <Effect>[
          FadeEffect(),
          SlideEffect(begin: Offset(0, 0.45)),
        ],
        child: hero,
      );
    } else {
      return hero;
    }
  }
}

import 'package:ditto/services/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants/app_enums.dart';

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Animate(
      delay: const Duration(milliseconds: 400),
      effects: const <Effect>[FadeEffect(), SlideEffect(begin: Offset(0, 0.5))],
      child: KeshiLogo(
        width: 125,
      ),
    );
  }
}

class KeshiLogo extends StatelessWidget {
  const KeshiLogo({
    super.key,
    required this.width,
    this.isHero = true,
  });

  final double width;
  final bool isHero;
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    final widget = Image.asset(
      AppUtils.instance.appLogoSelector(
        isDarkTheme ? AppLogoStyle.whiteBig : AppLogoStyle.blackBig,
      ),
      width: width,
    );
    if (isHero) {
      return Hero(
        tag: "KeshiLogo",
        child: widget,
      );
    } else {
      return widget;
    }
  }
}

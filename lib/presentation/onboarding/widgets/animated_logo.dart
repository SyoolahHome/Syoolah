import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditto/services/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../sign_up/widgets/logo.dart';

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Animate(
      delay: const Duration(milliseconds: 400),
      effects: const <Effect>[FadeEffect(), SlideEffect(begin: Offset(0, 0.5))],
      child: MunawarahLogo(
        width: mq.size.width * .55,
      ),
    );
  }
}

class MunawarahLogo extends StatelessWidget {
  const MunawarahLogo({
    super.key,
    required this.width,
    this.isHero = true,
  });

  final double width;
  final bool isHero;
  @override
  Widget build(BuildContext context) {
    final widget = Image.asset(
      AppUtils.appLogoSelector(AppLogoStyle.black),
      width: width,
    );
    if (isHero) {
      return Hero(
        tag: "MunawarahLogo",
        child: widget,
      );
    } else {
      return widget;
    }
  }
}

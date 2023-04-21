import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditto/services/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../home/widgets/logo.dart';

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Animate(
      delay: const Duration(milliseconds: 400),
      effects: const <Effect>[FadeEffect(), SlideEffect(begin: Offset(0, 0.5))],
      child: Image.asset(
        AppUtils.appLogoSelector(AppLogoStyle.black),
        width: mq.size.width * .55,
      ),
    );
  }
}

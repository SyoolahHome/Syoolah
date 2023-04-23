import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'dark_mode_icon.dart';
import 'profile_icon.dart';
import 'relays_widget.dart';
import 'search_icon.dart';
import 'translate_icon.dart';

class OnboardingActions extends StatelessWidget {
  const OnboardingActions({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return Animate(
      effects: const [
        FadeEffect(),
        SlideEffect(begin: Offset(0, 0.5)),
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          RelaysWidget(),
          SizedBox(width: height),
          ProfileIcon(),
          SizedBox(width: height),
          SearchIcon(),
          SizedBox(width: height),
          DarkIcon(),
          SizedBox(width: height),
          TranslateIcon(),
        ],
      ),
    );
  }
}

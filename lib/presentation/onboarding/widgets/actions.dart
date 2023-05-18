import 'package:ditto/presentation/onboarding/widgets/dark_mode_icon.dart';
import 'package:ditto/presentation/onboarding/widgets/profile_icon.dart';
import 'package:ditto/presentation/onboarding/widgets/relays_widget.dart';
import 'package:ditto/presentation/onboarding/widgets/search_icon.dart';
import 'package:ditto/presentation/onboarding/widgets/translate_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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

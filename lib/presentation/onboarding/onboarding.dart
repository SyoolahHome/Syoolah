import 'package:ditto/buisness_logic/on_boarding/on_boarding_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/onboarding/widgets/about_link.dart';
import 'package:ditto/presentation/onboarding/widgets/actions.dart';
import 'package:ditto/presentation/onboarding/widgets/animated_logo.dart';
import 'package:ditto/presentation/onboarding/widgets/get_started.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return BlocProvider<OnBoardingCubit>.value(
      value: Routing.onBoardingCubit,
      child: SafeArea(
        child: Scaffold(
          body: MarginedBody(
            margin: MarginedBody.defaultMargin +
                const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: const <Widget>[
                SizedBox(height: height * 3),
                OnboardingActions(),
                Spacer(),
                AnimatedLogo(),
                SizedBox(height: height * 3),
                GetStarted(),
                Spacer(),
                SizedBox(height: height),
                AboutRoundabout(),
                SizedBox(height: height * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

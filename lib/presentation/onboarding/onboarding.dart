import 'package:ditto/constants/colors.dart';
import 'package:ditto/presentation/home/widgets/logo.dart';
import 'package:ditto/presentation/onboarding/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/on_boarding/on_boarding_cubit.dart';
import '../general/widget/margined_body.dart';
import 'widgets/about_link.dart';
import 'widgets/actions.dart';
import 'widgets/animated_logo.dart';
import 'widgets/app_bar.dart';
import 'widgets/get_started.dart';
import 'widgets/munawarah_short_description.dart';
import 'widgets/profile_icon.dart';
import 'widgets/relays_widget.dart';
import 'widgets/search_icon.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return BlocProvider<OnBoardingCubit>(
      create: (context) => OnBoardingCubit(),
      child: SafeArea(
        child: Scaffold(
          body: MarginedBody(
            margin: MarginedBody.defaultMargin +
                const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:const <Widget>[
                 SizedBox(height: height * 3),
                 OnboardingActions(),
                 Spacer(),
                 AnimatedLogo(),
                 Spacer(),
                 SizedBox(height: height * 2),
                 GetStarted(),
                 SizedBox(height: height),
                 AboutMinawarah(),
                 SizedBox(height: height * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

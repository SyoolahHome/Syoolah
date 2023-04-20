import 'package:ditto/constants/colors.dart';
import 'package:ditto/presentation/home/widgets/logo.dart';
import 'package:ditto/presentation/onboarding/widgets/title.dart';
import 'package:flutter/material.dart';

import '../general/widget/margined_body.dart';
import 'widgets/about_link.dart';
import 'widgets/animated_logo.dart';
import 'widgets/app_bar.dart';
import 'widgets/get_started.dart';
import 'widgets/munawarah_short_description.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: MarginedBody(
          margin: MarginedBody.defaultMargin +
              const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // const SizedBox.shrink(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  SizedBox(height: height * 6),
                  Center(child: AnimatedLogo()),
                ],
              ),
              Column(
                children: const <Widget>[
                  // MunawarahTitle(),
                  // SizedBox(height: height),
                  MunawarahShortDescription(),
                  SizedBox(height: height * 4),
                  GetStarted(),
                  SizedBox(height: height),
                  AboutMinawarah(),
                  SizedBox(height: height * 2),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

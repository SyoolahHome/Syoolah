import 'package:ditto/buisness_logic/bottom_bar/bottom_bar_cubit.dart';
import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/onboarding/widgets/animated_logo.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../buisness_logic/lnd/lnd_cubit.dart';
import '../../constants/abstractions/abstractions.dart';
import '../../services/bottom_sheet/bottom_sheet_service.dart';
import '../general/widget/button.dart';
import 'widgets/lnd_bar.dart';

class LND extends BottomBarScreen {
  const LND({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LNDAppBar(),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedLogo(),
              SizedBox(height: 20),
              Animate(
                effects: const <Effect>[
                  FadeEffect(),
                  SlideEffect(begin: Offset(0, 0.45)),
                ],
                delay: Animate.defaultDuration * 3,
                child: Text(
                  "noLndSupport".tr().replaceAll("\n", "\n\n"),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Animate(
                  effects: const <Effect>[
                    FadeEffect(),
                    SlideEffect(begin: Offset(0, 0.45)),
                  ],
                  delay: Animate.defaultDuration * 6,
                  child: KeshiButton(
                    isRounded: true,
                    isSmall: false,
                    text: "goHome".tr(),
                    onTap: () {
                      final cubit = context.read<BottomBarCubit>();

                      cubit.onItemTapped(3);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Animate(
                effects: const <Effect>[
                  FadeEffect(),
                  SlideEffect(begin: Offset(0, 0.45)),
                ],
                delay: Animate.defaultDuration * 9,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "poweredBy".tr(),
                      ),
                      const TextSpan(text: " "),
                      TextSpan(
                        text: "AbuCash",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              SizedBox(height: kToolbarHeight),
            ],
          ),
        ),
      ),
    );

    return BlocProvider<LndCubit>(
      create: (context) => LndCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<LndCubit>();

          return Scaffold(
            appBar: LNDAppBar(),
            body: SizedBox(
              width: double.infinity,
              child: MarginedBody(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Support for Zaplocker coming Comex Bahrain 2023.",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Spacer(),
                    Animate(
                      effects: <Effect>[
                        SlideEffect(
                          begin: Offset(0, -0.075),
                          end: Offset(0, 0.075),
                          duration: 3000.ms,
                        ),
                      ],
                      onComplete: (controller) =>
                          controller.repeat(reverse: true),
                      child: Container(
                        padding: EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          FlutterRemix.flashlight_line,
                          color: Colors.yellow,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "lnd_description".tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 32.5),
                    OrDivider(
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(.5),
                    ),
                    const SizedBox(height: 32.5),
                    KeshiButton(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      onTap: () async {
                        final username = await BottomSheetService
                            .promptUserForNewLndUsername(
                          context: context,
                        );

                        Navigator.of(context).pushNamed(
                          Paths.lndLoading,
                          arguments: {
                            'cubit': cubit,
                            'username': username,
                          },
                        );
                      },
                      text: "start".tr(),
                      additonalFontSize: 0,
                      isRounded: true,
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

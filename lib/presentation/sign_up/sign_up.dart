import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import '../../buisness_logic/auth_cubit/auth_cubit.dart';
import '../../services/utils/paths.dart';
import '../../services/utils/snackbars.dart';
import '../general/auth_app_handler.dart';
import '../general/widget/button.dart';
import '../general/widget/margined_body.dart';
import '../general/widget/title.dart';
import 'widgets/app_bar.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final cubit = context.read<AuthCubit>();

    // final signUpScreens = cubit.state.signUpScreens;
    final signUpScreens = cubit.signUpScreens;

    final stepsLength = signUpScreens.length;

    Widget widget(index) {
      final current = signUpScreens[index];
      final labelLarge = Theme.of(context).textTheme.labelLarge;
      if (labelLarge == null) {
        throw Exception("labelLarge is null");
      }
      final animationDuration = 200.ms;

      return MarginedBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Animate(
              child: HeadTitle(
                title: current.title,
                isForSection: true,
              ),
              effects: const <Effect>[
                FadeEffect(),
                SlideEffect(
                  begin: Offset(-0.25, 0),
                ),
              ],
            ),
            const SizedBox(height: height * 2),
            Animate(
              child: Text(
                current.subtitle,
                style: labelLarge.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              effects: const <Effect>[
                FadeEffect(),
                SlideEffect(
                  begin: Offset(-0.25, 0),
                ),
              ],
              delay: animationDuration,
            ),
            const Spacer(),
            Animate(
              child: current.widgetBody,
              effects: const <Effect>[
                FadeEffect(),
                SlideEffect(
                  begin: Offset(-0.25, 0),
                ),
              ],
              delay: animationDuration,
            ),
            const Spacer(),
          ],
        ),
      );
    }

    return AuthenticationStreamHandler(
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(screenWidth, screenHeight)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const CustomAppBar(),
                const SizedBox(height: height * 10),
                Flexible(
                  child: PageView(
                    controller: cubit.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List<Widget>.generate(stepsLength, widget),
                    allowImplicitScrolling: false,
                  ),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final isLastView = state.currentStepIndex == stepsLength;

                    final current = signUpScreens[state.currentStepIndex - 1];

                    void onMainButtonPressed() {
                      if (!(Routing.authCubit.state.authenticated ||
                          !isLastView)) {
                        return;
                      }

                      final onButtonTap = current.onButtonTap;
                      if (!current.nextViewAllower()) {
                        final val = SnackBars.text(
                          context,
                          "finishThisStepFirst".tr(),
                          isError: true,
                        );
                      } else {
                        if (onButtonTap != null) {
                          onButtonTap();
                        }
                        if (isLastView) {
                          final val = Navigator.of(context)
                              .pushNamed(Paths.nostrServiceLoading);
                        } else {
                          cubit.gotoNext();
                        }
                      }
                    }

                    String? textDecider() {
                      final textIfAuthenticated =
                          Routing.authCubit.state.authenticated
                              ? "start".tr()
                              : null;

                      return isLastView
                          ? textIfAuthenticated
                          : "continueText".tr();
                    }

                    Widget? customWidgetDecider() {
                      return Routing.authCubit.state.authenticated ||
                              !isLastView
                          ? null
                          : SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.2,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            );
                    }

                    final animationDuration = 600.ms;
                    final height = 45.0;

                    return Animate(
                      child: MarginedBody(
                        child: SizedBox(
                          width: double.infinity,
                          height: height,
                          child: Stack(
                            alignment: Alignment.centerRight,
                            fit: StackFit.expand,
                            children: <Widget>[
                              MunawarahButton(
                                onTap: onMainButtonPressed,
                                text: textDecider(),
                                customWidget: customWidgetDecider(),
                              ),
                              if (!isLastView)
                                Animate(
                                  effects: <Effect>[FadeEffect()],
                                  delay: 2000.ms,
                                  child: Positioned(
                                    right:
                                        MarginedBody.defaultMargin.horizontal /
                                            2,
                                    child: Icon(
                                      FlutterRemix.arrow_right_line,
                                      size: 21,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      effects: const <Effect>[
                        FadeEffect(),
                        SlideEffect(begin: Offset(0, 0.25)),
                      ],
                      delay: animationDuration,
                    );
                  },
                ),
                const SizedBox(height: height),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

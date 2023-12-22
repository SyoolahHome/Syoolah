import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../buisness_logic/lnd/lnd_cubit.dart';
import '../../constants/abstractions/abstractions.dart';
import '../general/widget/button.dart';
import 'widgets/lnd_bar.dart';

class LND extends BottomBarScreen {
  const LND({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                    SakhirButton(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      onTap: () {
                        cubit.onCreateAdressClick(context);
                      },
                      text: "create_lightning_address".tr(),
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

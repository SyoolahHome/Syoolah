import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../buisness_logic/nip05_verification/nip05_verification_cubit.dart';
import '../../services/nostr/nostr_service.dart';
import '../../services/utils/snackbars.dart';
import '../general/text_field.dart';
import '../general/widget/button.dart';
import '../general/widget/margined_body.dart';
import '../general/widget/title.dart';
import 'widgets/app_bar.dart';

class Nip05Verification extends StatelessWidget {
  const Nip05Verification({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;
    final animationDuration = Animate.defaultDuration;

    final currentUserPrivateKey = LocalDatabase.instance.getPrivateKey()!;
    final currentUserPublicKey = Nostr.instance.keysService
        .derivePublicKey(privateKey: currentUserPrivateKey);

    return BlocProvider<Nip05VerificationCubit>(
      create: (context) => Nip05VerificationCubit(
        currentUserMetadata: NostrService.instance.subs.userMetaData(
          userPubKey: currentUserPublicKey,
        ),
      ),
      child: Builder(builder: (context) {
        final cubit = context.read<Nip05VerificationCubit>();

        return BlocListener<Nip05VerificationCubit, Nip05VerificationState>(
          listener: (context, state) {
            if (state.error != null) {
              SnackBars.text(context, state.error!);
            }
          },
          child: Scaffold(
            appBar: CustomAppBar(),
            body: MarginedBody(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: height * 3),
                  Animate(
                    effects: const <Effect>[
                      FadeEffect(),
                      SlideEffect(
                        begin: Offset(-0.25, 0),
                      ),
                    ],
                    child: HeadTitle(
                      title: "lightningAddressesTitle".tr(),
                      isForSection: true,
                    ),
                  ),
                  const SizedBox(height: height * 2),
                  Animate(
                    effects: const <Effect>[
                      FadeEffect(),
                      SlideEffect(
                        begin: Offset(-0.25, 0),
                      ),
                    ],
                    delay: animationDuration,
                    child: Text(
                      "newLightningAddressesSubtitle".tr(),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ),
                  Spacer(),
                  Stack(
                    alignment:
                        AppUtils.instance.centerHorizontalAlignment(context),
                    children: <Widget>[
                      CustomTextField(
                        controller: cubit.nip05Controller,
                        // label: "yourLightAdress".tr(),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        hint: "newHintLightAdress".tr(),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: MarginedBody.defaultMargin.right,
                        ),
                        child: MunawarahButton(
                          additonalFontSize: 1,
                          onTap: () {
                            cubit.handleNip05Verification(
                              onSuccess: () {
                                SnackBars.text(
                                  context,
                                  "LightAdresSuccess".tr(),
                                );

                                Navigator.of(context).pop();
                              },
                            );
                          },
                          isSmall: true,
                          text: "verify".tr(),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

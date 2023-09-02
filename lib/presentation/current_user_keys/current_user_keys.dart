import 'package:ditto/presentation/current_user_keys/widgets/app_bar.dart';
import 'package:ditto/presentation/current_user_keys/widgets/danger_box.dart';
import 'package:ditto/presentation/current_user_keys/widgets/private_key_section.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:ditto/presentation/private_succes/widgets/key_section.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants/app_enums.dart';

class CurrentUserKeys extends StatelessWidget {
  const CurrentUserKeys({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: MarginedBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimateList(
              effects: <Effect>[
                const FadeEffect(),
                const SlideEffect(begin: Offset(0, 0.5)),
              ],
              interval: const Duration(milliseconds: 100),
              children: <Widget>[
                const SizedBox(height: height * 3),
                Text(
                  "keys".tr(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: height * 6),
                HeadTitle(title: "pubkey".tr()),
                const SizedBox(height: height),
                const KeySection(type: KeySectionType.publicKey),
                const SizedBox(height: height * 2),
                HeadTitle(title: "npub".tr()),
                const SizedBox(height: height),
                const KeySection(type: KeySectionType.nPubKey),
                const SizedBox(height: height * 4),
                const SizedBox(width: double.infinity, child: OrDivider()),
                DangerBox(
                  bgColor: Theme.of(context)
                      .colorScheme
                      .errorContainer
                      .withOpacity(.45),
                  titleText: "newKeysDangerTitle".tr(),
                  // messageText: "dangerDoNotSharePrivateKeys".tr(),
                ),
                const SizedBox(height: height * 3),
                HeadTitle(title: "privkey".tr()),
                const SizedBox(height: height),
                const HiddenPrivateKeySection(
                  type: HiddenPrivateKeySectionType.privateKey,
                ),
                const SizedBox(height: height * 2),
                HeadTitle(title: "nsec".tr()),
                const SizedBox(height: height),
                const HiddenPrivateKeySection(
                  type: HiddenPrivateKeySectionType.nsecKey,
                ),
                const SizedBox(height: height * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

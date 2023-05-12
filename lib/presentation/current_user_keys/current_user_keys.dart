import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:ditto/presentation/private_succes/widgets/key_section.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'widgets/app_bar.dart';
import 'widgets/danger_box.dart';
import 'widgets/private_key_section.dart';

class CurrentUserKeys extends StatelessWidget {
  const CurrentUserKeys({super.key});

  @override
  Widget build(BuildContext context) {
    final height = 10.0;

    return Scaffold(
      appBar: CustomAppBar(),
      body: MarginedBody(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimateList(
              effects: <Effect>[
                FadeEffect(),
                SlideEffect(
                  begin: Offset(0, 0.5),
                ),
              ],
              interval: Duration(milliseconds: 100),
              children: <Widget>[
                SizedBox(height: height * 3),
                Text(
                  "myKeys".tr(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: height * 6),
                HeadTitle(title: "myPublicKey".tr()),
                SizedBox(height: height),
                KeySection(type: KeySectionType.publicKey),
                SizedBox(height: height * 2),
                HeadTitle(title: "nPubKey".tr()),
                SizedBox(height: height),
                KeySection(type: KeySectionType.nPubKey),
                SizedBox(height: height * 4),
                SizedBox(width: double.infinity, child: OrDivider()),
                SizedBox(height: height * 4),
                HeadTitle(title: "myPrivateKey".tr()),
                DangerBox(),
                SizedBox(height: height * 3),
                HiddenPrivateKeySection(
                  type: HiddenPrivateKeySectionType.privateKey,
                ),
                SizedBox(height: height * 2),
                HiddenPrivateKeySection(
                  type: HiddenPrivateKeySectionType.nsecKey,
                ),
              ],
            )),
      ),
    );
  }
}

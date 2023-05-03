import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/constants/app_strings.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:ditto/presentation/private_succes/widgets/key_section.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:flutter/material.dart';

import '../../services/bottom_sheet/bottom_sheet_service.dart';
import 'widgets/app_bar.dart';
import 'widgets/private_key_section.dart';

class CurrentUserKeys extends StatelessWidget {
  const CurrentUserKeys({super.key});

  @override
  Widget build(BuildContext context) {
    final height = 10.0;
    final privateKey = LocalDatabase.instance.getPrivateKey()!;
    final publicKey =
        Nostr.instance.keysService.derivePublicKey(privateKey: privateKey);

    return Scaffold(
      appBar: CustomAppBar(),
      body: MarginedBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: height * 3),
            Text(
              AppStrings.myKeys,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: height * 3),
            HeadTitle(title: AppStrings.myPublicKey),
            SizedBox(height: height),
            KeySection(type: KeySectionType.publicKey),
            SizedBox(height: height * 2),
            HeadTitle(title: AppStrings.nPubKey),
            SizedBox(height: height),
            KeySection(type: KeySectionType.nPubKey),
            SizedBox(height: height * 6),
            HeadTitle(title: AppStrings.myPrivateKey),
            SizedBox(height: height),
            HiddenPrivateKeySection(
              type: HiddenPrivateKeySectionType.privateKey,
            ),
            HiddenPrivateKeySection(
              type: HiddenPrivateKeySectionType.nsecKey,
            ),
          ],
        ),
      ),
    );
  }
}

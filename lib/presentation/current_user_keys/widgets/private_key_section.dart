import 'package:dart_nostr/dart_nostr.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_strings.dart';
import '../../../services/bottom_sheet/bottom_sheet_service.dart';
import '../../../services/database/local/local_database.dart';
import '../../general/widget/button.dart';

enum HiddenPrivateKeySectionType {
  privateKey,
  nsecKey,
}

class HiddenPrivateKeySection extends StatelessWidget {
  const HiddenPrivateKeySection({
    super.key,
    required this.type,
  });

  final HiddenPrivateKeySectionType type;
  @override
  Widget build(BuildContext context) {
    final privateKey = LocalDatabase.instance.getPrivateKey()!;

    final hiddenPrivateKey = privateKey.substring(0, 7) +
        '...' +
        privateKey.substring(privateKey.length - 7, privateKey.length);

    final nsecKey =
        Nostr.instance.keysService.encodePrivateKeyToNsec(privateKey);

    final hiddenNsecKey = nsecKey.substring(0, 5) +
        '...' +
        nsecKey.substring(nsecKey.length - 5, nsecKey.length);

    final hiddenKey = type == HiddenPrivateKeySectionType.privateKey
        ? hiddenPrivateKey
        : hiddenNsecKey;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          hiddenKey,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        MunawarahButton(
          text: AppStrings.reveal,
          onTap: () {
            final val = BottomSheetService.showKey(
              context,
              type: type,
            );
          },
        ),
      ],
    );
  }
}

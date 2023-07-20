import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../general/nip_05_verification_symbol_check_widget.dart';

class ProfileName extends StatelessWidget {
  const ProfileName({
    super.key,
    required this.metadata,
    required this.pubKey,
  });

  final UserMetaData metadata;
  final String pubKey;
  @override
  Widget build(BuildContext context) {
    final String toShow = metadata.nameToShow();
    final String internetIdentifier = metadata.nip05Identifier ?? "";

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Animate(
          effects: const [FadeEffect()],
          delay: 600.ms,
          child: Text(
            toShow.capitalized,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(width: 5),
        NIP05VerificationSymbolWidget(
          internetIdentifier: internetIdentifier,
          pubKey: pubKey,
        ),
      ],
    );
  }
}

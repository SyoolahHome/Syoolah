import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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

    Future<bool> future() async {
      if (Nostr.instance.utilsService
          .isValidNip05Identifier(internetIdentifier)) {
        return Nostr.instance.relaysService.verifyNip05(
          internetIdentifier: internetIdentifier,
          pubKey: pubKey,
        );
      } else {
        return false;
      }
    }

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
        FutureBuilder<bool>(
          future: future(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                return Animate(
                  effects: const [FadeEffect()],
                  child: const Icon(
                    Icons.verified,
                    color: Colors.green,
                    size: 15,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}

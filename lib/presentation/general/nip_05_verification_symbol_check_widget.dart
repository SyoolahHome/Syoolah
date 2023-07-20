import 'package:dart_nostr/dart_nostr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NIP05VerificationSymbolWidget extends StatelessWidget {
  const NIP05VerificationSymbolWidget({
    super.key,
    required this.internetIdentifier,
    required this.pubKey,
  });

  final String pubKey;
  final String internetIdentifier;

  @override
  Widget build(BuildContext context) {
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

    return FutureBuilder<bool>(
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
    );
    ;
  }
}

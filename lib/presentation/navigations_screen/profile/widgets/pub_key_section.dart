import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:flutter/material.dart';

class PublicKeySection extends StatelessWidget {
  const PublicKeySection({super.key});

  @override
  Widget build(BuildContext context) {
    final publicKey = Nostr.instance.keysService.derivePublicKey(
      privateKey: LocalDatabase.instance.getPrivateKey()!,
    );

    return Container(
      child: Text(publicKey),
    );
  }
}

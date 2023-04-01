import 'package:ditto/services/database/local/local.dart';
import 'package:flutter/material.dart';
import 'package:nostr/nostr.dart';

class CurrentUserPubKey extends StatelessWidget {
  const CurrentUserPubKey({
    super.key,
    required this.pubKey,
  });

  final String pubKey;
  @override
  Widget build(BuildContext context) {
    return Text(pubKey);
  }
}

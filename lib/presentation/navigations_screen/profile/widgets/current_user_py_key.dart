import 'package:flutter/material.dart';

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

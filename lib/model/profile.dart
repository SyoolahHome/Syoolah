import 'package:flutter/material.dart';
import 'package:nostr/nostr.dart';

class MProfile with ChangeNotifier {
  Keychain keys = Keychain.generate();
  String relay = "wss://relay.dispute.systems";
}

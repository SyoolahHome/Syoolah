import 'dart:convert';
import 'dart:core';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:ditto/services/database/local/local.dart';
import 'package:ditto/services/nostr/base/nostr.dart';
import 'package:nostr/nostr.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../model/event.dart';
import '../../model/request.dart';

final relaysUrl = 'wss://relay.damus.io';

final NostrService _instance = NostrService._();

class NostrService implements NostrServiceBase {
  static NostrService get instance => _instance;
  NostrService._();

  @override
  String generateKeys() {
    final keyChain = Keychain.generate();

    return keyChain.private;
  }
}

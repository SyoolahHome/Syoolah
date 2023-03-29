import 'package:ditto/services/nostr/base/nostr.dart';
import 'package:nostr/nostr.dart';

class NostrService implements NostrServiceBase {
  static final NostrService _instance = NostrService._();
  static NostrService get instance => _instance;
  NostrService._();

  @override
  String generateKeys() {
    final keyChain = Keychain.generate();

    return keyChain.private;
  }
}

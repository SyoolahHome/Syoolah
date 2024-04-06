import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:dart_nostr/dart_nostr.dart';
import 'package:kepler/kepler.dart';
import 'package:pointycastle/export.dart';

/// Encrypted Direct Message
class Nip4 {
  /// Returns the EDMessage Encrypted Direct Message event (kind=4)
  ///
  /// ```dart
  ///  var event = Event.from(
  ///    pubkey: senderPubKey,
  ///    created_at: 12121211,
  ///    kind: 4,
  ///    tags: [
  ///      ["p", receiverPubKey],
  ///      ["e", <event-id>, <relay-url>, <marker>],
  ///    ],
  ///    content: "wLzN+Wt2vKhOiO8v+FkSzA==?iv=X0Ura57af2V5SuP80O6KkA==",
  ///  );
  ///
  ///  EDMessage eDMessage = Nip4.decode(event);
  ///```
  static Future<EDMessage?> decode(
    NostrEvent event,
    NostrKeyPairs keyPair,
  ) async {
    if (event.kind == 4) {
      return _toEDMessage(event, keyPair);
    }
    return null;
  }

  /// Returns EDMessage from event
  static Future<EDMessage> _toEDMessage(
    NostrEvent event,
    NostrKeyPairs keyPair,
  ) async {
    final sender = event.pubkey;
    final createdAt = event.createdAt!.millisecondsSinceEpoch ~/ 1000;
    var receiver = '';
    var replyId = '';
    var content = '';
    var subContent = event.content!;

    String? expiration;
    for (final tag in event.tags!) {
      if (tag[0] == 'p') receiver = tag[1];
      if (tag[0] == 'e') replyId = tag[1];
      if (tag[0] == 'subContent') subContent = tag[1];
      if (tag[0] == 'expiration') expiration = tag[1];
    }
    if (receiver.compareTo(keyPair.public) == 0) {
      content = decryptContent(subContent, sender, keyPair);
    } else if (sender.compareTo(keyPair.public) == 0) {
      content = decryptContent(subContent, receiver, keyPair);
    } else {
      throw Exception('not correct receiver, is not nip4 compatible');
    }

    return EDMessage(sender, receiver, createdAt, content, replyId, expiration);
  }

  static String decryptContent(
    String content,
    String peerPubkey,
    NostrKeyPairs keyPair,
  ) {
    final ivIndex = content.indexOf('?iv=');
    if (ivIndex <= 0) {
      print('Invalid content for dm, could not get ivIndex: $content');
      return '';
    }
    final iv = content.substring(ivIndex + '?iv='.length, content.length);
    final encString = content.substring(0, ivIndex);
    try {
      return decrypt(keyPair.private, '02$peerPubkey', encString, iv);
    } catch (e) {
      return '';
    }
  }

  static Future<NostrEvent> encode(
    NostrKeyPairs keyPair,
    String receiver,
    String content,
    String replyId, {
    String? subContent,
    int? expiration,
  }) async {
    final enContent = encryptContent(
      content,
      receiver,
      keyPair,
    );

    final tags = toTags(receiver, replyId, expiration);
    if (subContent != null && subContent.isNotEmpty) {
      final enSubContent = encryptContent(
        subContent,
        receiver,
        keyPair,
      );

      tags.add(['subContent', enSubContent]);
    }
    final event = NostrEvent.fromPartialData(
      kind: 4,
      tags: tags,
      content: enContent,
      keyPairs: keyPair,
    );

    return event;
  }

  static String encryptContent(
    String plainText,
    String peerPubkey,
    NostrKeyPairs keyPair,
  ) {
    return encrypt(keyPair.private, '02$peerPubkey', plainText);
  }

  static List<List<String>> toTags(String p, String e, int? expiration) {
    final result = <List<String>>[];
    result.add(['p', p]);
    if (e.isNotEmpty) result.add(['e', e, '', 'reply']);
    if (expiration != null) result.add(['expiration', expiration.toString()]);
    return result;
  }
}

/// ```
class EDMessage {
  /// Default constructor
  EDMessage(
    this.sender,
    this.receiver,
    this.createdAt,
    this.content,
    this.replyId,
    this.expiration,
  );
  String sender;

  String receiver;

  int createdAt;

  String content;

  String replyId;

  String? expiration;
}

// Encrypt data using self private key in nostr format ( with trailing ?iv=)
String encrypt(String privateString, String publicString, String plainText) {
  final uintInputText = const Utf8Encoder().convert(plainText);
  final encryptedString =
      encryptRaw(privateString, publicString, uintInputText);
  return encryptedString;
}

String encryptRaw(
  String privateString,
  String publicString,
  Uint8List uintInputText,
) {
  final secretIV = Kepler.byteSecret(privateString, publicString);
  final key = Uint8List.fromList(secretIV[0]);

  // generate iv  https://stackoverflow.com/questions/63630661/aes-engine-not-initialised-with-pointycastle-securerandom
  final fr = FortunaRandom();
  final sGen = Random.secure();
  fr.seed(
    KeyParameter(
      Uint8List.fromList(List.generate(32, (_) => sGen.nextInt(255))),
    ),
  );
  final iv = fr.nextBytes(16);

  final CipherParameters params = PaddedBlockCipherParameters(
    ParametersWithIV(KeyParameter(key), iv),
    null,
  );

  final cipherImpl =
      PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()));

  cipherImpl.init(
    true, // means to encrypt
    params as PaddedBlockCipherParameters<CipherParameters?, CipherParameters?>,
  );

  // allocate space
  final outputEncodedText = Uint8List(uintInputText.length + 16);

  var offset = 0;
  while (offset < uintInputText.length - 16) {
    offset += cipherImpl.processBlock(
      uintInputText,
      offset,
      outputEncodedText,
      offset,
    );
  }

  //add padding
  offset +=
      cipherImpl.doFinal(uintInputText, offset, outputEncodedText, offset);
  final finalEncodedText = outputEncodedText.sublist(0, offset);

  final stringIv = base64.encode(iv);
  var outputPlainText = base64.encode(finalEncodedText);
  outputPlainText = '$outputPlainText?iv=$stringIv';
  return outputPlainText;
}

// pointy castle source https://github.com/PointyCastle/pointycastle/blob/master/tutorials/aes-cbc.md
// https://github.com/bcgit/pc-dart/blob/master/tutorials/aes-cbc.md
// 3 https://github.com/Dhuliang/flutter-bsv/blob/42a2d92ec6bb9ee3231878ffe684e1b7940c7d49/lib/src/aescbc.dart

/// Decrypt data using self private key
String decrypt(
  String privateString,
  String publicString,
  String b64encoded, [
  String b64IV = '',
]) {
  final deData = base64.decode(b64encoded);
  final rawData = decryptRaw(privateString, publicString, deData, b64IV);
  return const Utf8Decoder().convert(rawData.toList());
}

Uint8List decryptRaw(
  String privateString,
  String publicString,
  Uint8List cipherText, [
  String b64IV = '',
]) {
  final byteSecret = Kepler.byteSecret(privateString, publicString);
  final secretIV = byteSecret;
  final key = Uint8List.fromList(secretIV[0]);
  final iv =
      b64IV.length > 6 ? base64.decode(b64IV) : Uint8List.fromList(secretIV[1]);

  final CipherParameters params = PaddedBlockCipherParameters(
    ParametersWithIV(KeyParameter(key), iv),
    null,
  );

  final cipherImpl =
      PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()));

  cipherImpl.init(
    false,
    params as PaddedBlockCipherParameters<CipherParameters?, CipherParameters?>,
  );
  final finalPlainText = Uint8List(cipherText.length); // allocate space

  var offset = 0;
  while (offset < cipherText.length - 16) {
    offset +=
        cipherImpl.processBlock(cipherText, offset, finalPlainText, offset);
  }
  //remove padding
  offset += cipherImpl.doFinal(cipherText, offset, finalPlainText, offset);
  return finalPlainText.sublist(0, offset);
}

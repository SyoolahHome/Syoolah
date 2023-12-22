import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:kepler/kepler.dart';
import 'package:pointycastle/export.dart';

class NostrServiceUtils {
  String nip04Encrypt({
    required String privKey,
    required String pubKey,
    required String text,
  }) {
    Uint8List uintInputText = const Utf8Encoder().convert(text);

    // Generate the shared secret and use the first 32 bytes as the encryption key.
    final secretIV = Kepler.byteSecret(privKey, '02$pubKey');
    final key = Uint8List.fromList(secretIV[0]);

    // generate iv  https://stackoverflow.com/questions/63630661/aes-engine-not-initialised-with-pointycastle-securerandom
    // Generate a random 16-byte initialization vector (IV) using the Fortuna
    // random number generator.
    FortunaRandom fr = FortunaRandom();
    final sGen = Random.secure();
    fr.seed(KeyParameter(
        Uint8List.fromList(List.generate(32, (_) => sGen.nextInt(255)))));
    final iv = fr.nextBytes(16);

    // Define the encryption parameters using the key and IV.
    CipherParameters params = PaddedBlockCipherParameters(
        ParametersWithIV(KeyParameter(key), iv), null);

    // Initialize the AES-256-CBC cipher with PKCS7 padding.
    PaddedBlockCipherImpl cipherImpl =
        PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()));

    // Initialize the cipher with the encryption parameters.
    cipherImpl.init(
      true, // means to encrypt
      params
          as PaddedBlockCipherParameters<CipherParameters?, CipherParameters?>,
    );

    // Allocate space for the encrypted output buffer.
    final outputEncodedText = Uint8List.view(
      Uint8List(uintInputText.length + 16).buffer,
      0,
      uintInputText.length + 16,
    );

    // Encrypt the plain text message in blocks and write the encrypted bytes to
    // the output buffer.
    var offset = 0;
    while (offset < uintInputText.length - 16) {
      offset += cipherImpl.processBlock(
        uintInputText,
        offset,
        outputEncodedText,
        offset,
      );
    }

    // Add padding and write the remaining encrypted bytes to the output buffer.
    offset +=
        cipherImpl.doFinal(uintInputText, offset, outputEncodedText, offset);

    // Extract the encrypted bytes from the output buffer and create a new
    // Uint8List containing only the encrypted bytes.
    final Uint8List finalEncodedText = outputEncodedText.sublist(0, offset);

    // Encode the IV as a Base64 string.
    String stringIv = base64.encode(iv);

    // Encode the encrypted bytes as a Base64 string and append the IV to the end
    final cipherText = "${base64.encode(finalEncodedText)}?iv=$stringIv";

    // Return the encrypted message.
    return cipherText;
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'lnd_state.dart';

class LndCubit extends Cubit<LndState> {
  TextEditingController? usernameController;

  final server = "https://2b35-102-101-252-112.ngrok-free.app";

  LndCubit() : super(LndInitial()) {
    _init();
  }

  Future<void> close() {
    usernameController?.dispose();

    return super.close();
  }

  void onCreateAdressClick(BuildContext context) {
    BottomSheetService.createLndAddress(this, context);
  }

  _init() {
    usernameController = TextEditingController()
      ..addListener(() {
        emit(state.copyWith(username: usernameController!.text));
      });
  }

  void createAddress({
    required Null Function() onSuccess,
  }) async {
    final privateKey = LocalDatabase.instance.getPrivateKey()!;
    final derivedPublicKey = Nostr.instance.keysService.derivePublicKey(
      privateKey: privateKey,
    );
    try {
      emit(state.copyWith(isLoading: true));
      await _createLndAddress(derivedPublicKey);
      onSuccess();
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _createLndAddress(String userPubkey) async {
    final url = Uri.parse(server + '/test_pubkey/?pubkey=${userPubkey}');

    final userData = await _getData(url);

    if (!userData.toLowerCase().contains("error: invalid pubkey")) {
      loadUser(userPubkey, userData);
    }
  }

  Future<String> _getData(Uri uri) async {
    try {
      final response = await http.get(uri);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.body;
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  void loadUser(
    String userPubkey,
    String userData,
  ) {
    final decoded = jsonDecode(userData) as Map<String, dynamic>;
    print("username: " + decoded['username']);

    final hex =
        textToHex(server + "/.well-known/lnurlp/" + decoded["username"]);

    final toBytes = hexToBytes(hex);
    final words = toWords(toBytes);

    final bech32 = Nostr.instance.utilsService.encodeBech32(words, "lnurl");
  }

  Uint8List hexToBytes(String hexString) {
    final hexWithoutPrefix = hexString.replaceAll('0x', '');
    final bytes = Uint8List.fromList(List.generate(
        hexWithoutPrefix.length ~/ 2,
        (i) => int.parse(hexWithoutPrefix.substring(i * 2, (i + 1) * 2),
            radix: 16)));
    return bytes;
  }

  String textToHex(String text) {
    final bytes = utf8.encode(text);
    final hexString =
        bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
    return '0x$hexString';
  }

  List<int> convert(List<int> data, int inBits, int outBits, bool pad) {
    int value = 0;
    int bits = 0;
    final maxV = (1 << outBits) - 1;

    final result = <int>[];
    for (var i = 0; i < data.length; ++i) {
      value = (value << inBits) | data[i];
      bits += inBits;

      while (bits >= outBits) {
        bits -= outBits;
        result.add((value >> bits) & maxV);
      }
    }

    if (pad) {
      if (bits > 0) {
        result.add((value << (outBits - bits)) & maxV);
      }
    } else {
      if (bits >= inBits) return throw Exception('Excess padding');
      if ((value << (outBits - bits)) & maxV != 0)
        return throw Exception('Non-zero padding');
    }

    return result;
  }

  toWords(List<int> bytes) {
    final out = convert(bytes, 8, 5, true);
    return out;
  }
}

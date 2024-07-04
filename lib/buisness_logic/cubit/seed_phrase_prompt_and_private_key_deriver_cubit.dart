import 'package:bloc/bloc.dart';
import 'package:convert/convert.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
part 'seed_phrase_prompt_and_private_key_deriver_state.dart';

class SeedPhrasePromptAndPrivateKeyDeriverCubit
    extends Cubit<SeedPhrasePromptAndPrivateKeyDeriverState> {
  SeedPhrasePromptAndPrivateKeyDeriverCubit({
    required this.controllersKeys,
  }) : super(SeedPhrasePromptAndPrivateKeyDeriverInitial()) {
    _init();
  }

  final controllersMap = <String, TextEditingController>{};

  final List<String> controllersKeys;

  void _init() {
    final debugList = [
      "exclude",
      "twice",
      "aerobic",
      "flower",
      "sniff",
      "hedgehog",
      "fuel",
      "layer",
      "flavor",
      "display",
      "you",
      "avocado"
    ];

    int debugIndex = 0;

    for (final key in controllersKeys) {
      controllersMap[key] = TextEditingController(text: debugList[debugIndex]);
      debugIndex++;
    }
  }

  @override
  Future<void> close() {
    for (final controller in controllersMap.values) {
      controller.dispose();
    }

    return super.close();
  }

  void submit() async {
    try {
      final words = controllersMap.values.map((e) => e.text).toList();

      if (words.any((word) => word.isEmpty)) {
        throw Exception("Please fill all the 12 words");
      }

      final mnemonic = words.join(' ');
      final seed = bip39.mnemonicToSeed(mnemonic);
      final root = bip32.BIP32.fromSeed(seed);

      final path = "m/44'/1237'/0'/0/0";
      final privateKeyList = root.derivePath(path).privateKey;

      if (privateKeyList == null) {
        throw Exception('[!] could not derive private key');
      }

      final privateKey = hex.encode(privateKeyList);

      await LocalDatabase.instance.setAuthInformations(
        key: privateKey,
        mnemonic: mnemonic,
      );

      emit(state.copyWith(
        privateKey: privateKey,
      ));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}

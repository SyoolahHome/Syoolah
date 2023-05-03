import 'package:bloc/bloc.dart';
import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/presentation/private_succes/widgets/key_section.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_strings.dart';
import '../../services/database/local/local_database.dart';

part 'private_key_gen_success_state.dart';

class PrivateKeyGenSuccessCubit extends Cubit<PrivateKeyGenSuccessState> {
  PrivateKeyGenSuccessCubit() : super(PrivateKeyGenSuccessInitial()) {
    _initKeys();
  }

  void togglePrivateKeyFieldVisibility() {
    emit(state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
    ));
  }

  copyPrivateKey(BuildContext context) async {
    try {
      await Clipboard.setData(ClipboardData(text: state.privateKey));

      return SnackBars.text(context, AppStrings.privateKeyCopied);
    } catch (e) {
      return SnackBars.text(context, e.toString());
    }
  }

  copyPublicKey(context) async {
    try {
      final privateKey = LocalDatabase.instance.getPrivateKey();
      if (privateKey == null) {
        return;
      }
      await Clipboard.setData(
        ClipboardData(
          text: state.publicKey ??
              Nostr.instance.keysService
                  .derivePublicKey(privateKey: privateKey),
        ),
      );

      return SnackBars.text(context, AppStrings.publicKeyCopied);
    } catch (e) {
      return SnackBars.text(context, e.toString());
    }
  }

  String decideWhichKeyToShow(KeySectionType type) {
    switch (type) {
      case KeySectionType.publicKey:
        return state.publicKey!;
      case KeySectionType.privateKey:
        return state.privateKey!;
      case KeySectionType.nPubKey:
        return state.nPubKey!;
      case KeySectionType.nsecKey:
        return state.nsecKey!;
    }
  }

  void _initKeys() {
    final privateKey = LocalDatabase.instance.getPrivateKey()!;
    final publicKey =
        Nostr.instance.keysService.derivePublicKey(privateKey: privateKey);
    final nPubKey = Nostr.instance.keysService.encodePublicKeyToNpub(publicKey);
    final nsecKey =
        Nostr.instance.keysService.encodePrivateKeyToNsec(privateKey);
    emit(
      PrivateKeyGenSuccessInitial(
        privateKey: privateKey,
        publicKey: publicKey,
        nPubKey: nPubKey,
        nsecKey: nsecKey,
      ),
    );
  }
}

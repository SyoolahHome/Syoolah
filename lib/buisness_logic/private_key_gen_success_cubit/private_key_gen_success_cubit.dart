import 'package:bloc/bloc.dart';
import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_strings.dart';
import '../../services/database/local/local_database.dart';

part 'private_key_gen_success_state.dart';

class PrivateKeyGenSuccessCubit extends Cubit<PrivateKeyGenSuccessState> {
  PrivateKeyGenSuccessCubit()
      : super(PrivateKeyGenSuccessInitial(
          privateKey: LocalDatabase.instance.getPrivateKey(),
          publicKey: Nostr.instance.keysService.derivePublicKey(
            privateKey: LocalDatabase.instance.getPrivateKey() ?? "",
          ),
        ));

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
}

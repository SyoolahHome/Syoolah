import 'package:bloc/bloc.dart';
import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../constants/app_enums.dart';
import '../../services/utils/app_utils.dart';

part 'private_key_gen_success_state.dart';

/// {@template private_key_gen_success_cubit}
/// The responsible cubit about the private key generation success UI.
/// {@endtemplate}
class PrivateKeyGenSuccessCubit extends Cubit<PrivateKeyGenSuccessState> {
  /// {@macro private_key_gen_success_cubit}
  PrivateKeyGenSuccessCubit() : super(PrivateKeyGenSuccessState.initial()) {
    _init();
  }

  /// Toggles the visibility of the private key field.
  void togglePrivateKeyFieldVisibility() {
    final isPasswordVisible = !state.isPasswordVisible;

    emit(state.copyWith(isPasswordVisible: isPasswordVisible));
  }

  /// Copies the private key.
  Future<void> copyPrivateKey(BuildContext context) async {
    return AppUtils.instance.copy(
      state.privateKey ?? "",
      onSuccess: () => SnackBars.text(context, "privateKeyCopied".tr()),
      onError: () => SnackBars.text(context, "error".tr()),
    );

    // TODO: check this once more.
//
// //     try {
// //       await Clipboard.setData(ClipboardData(text: ));
// //
// //       return ;
// //     } catch (e) {
// //       return SnackBars.text(context, e.toString());
// //     }
  }

  /// Copies the public key.
  void copyPublicKey(BuildContext context) async {
// //     try {
// //       final privateKey = LocalDatabase.instance.getPrivateKey();
// //       if (privateKey == null) {
// //         return;
// //       }
// //
// //       await Clipboard.setData(
// //         ClipboardData(
// //           text: state.publicKey ??
// //               Nostr.instance.keysService
// //                   .derivePublicKey(privateKey: privateKey),
// //         ),
// //       );
// //
// //       return;
// //     } catch (e) {
// //       return SnackBars.text(context, e.toString());
// //     }
// //
    return AppUtils.instance.copy(
      state.publicKey ??
          Nostr.instance.keysService.derivePublicKey(
              privateKey: LocalDatabase.instance.getPrivateKey()!),
      onError: () => SnackBars.text(context, "error".tr()),
      onSuccess: () => SnackBars.text(context, "publicKeyCopied".tr()),
    );
  }

  /// Returns the relevent key based on the [type].
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

  void _init() {
    _initKeys();
  }
}

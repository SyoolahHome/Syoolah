import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../model/user_meta_data.dart';
import '../../../services/database/local/local_database.dart';
import '../../../services/nostr/nostr_service.dart';

part 'nip05_verification_state.dart';

/// {@template nip_05_verification_cubit}
/// The responsible cubit about the Lightning adresses (nip 05) verification.
/// {@endtemplate}
class Nip05VerificationCubit extends Cubit<Nip05VerificationState> {
  /// The text field controller that will take the adress or identifier to continue the verification process.
  TextEditingController? nip05Controller;

  /// The Nostr stream of the current user metadata.
  NostrEventsStream currentUserMetadata;

  /// The subscription of the [currentUserMetadata.stream].
  StreamSubscription? currentUserMetadataSubscription;

  /// {@macro nip_05_verification_cubit}
  Nip05VerificationCubit({
    required this.currentUserMetadata,
  }) : super(Nip05VerificationState.initial()) {
    _init();
  }

  @override
  Future<void> close() {
    currentUserMetadata.close();

    currentUserMetadataSubscription?.cancel();

    nip05Controller?.dispose();

    return super.close();
  }

  /// Starts & runs the verification process with the input of [nip05Controller].
  /// if the the input is not a valid adress, an error state will be emitted.
  /// if there is not existent initialuser metadata, the method will emit an error state as well, since we will need to update the profile with the new existent user metadata but with the verified field marked.
  /// The [onSuccess] will be called if the verification process is successful.
  Future<void> handleNip05Verification({
    required VoidCallback onSuccess,
  }) async {
    bool isVerified = await _verifyInputNip05();
    final currentUserMetadata = state.currentUserMetadata;

    if (isVerified &&
        nip05Controller!.text.isNotEmpty &&
        currentUserMetadata != null) {
      _updateCurrentUserProfileWithNip05(state.currentUserMetadata!);
      onSuccess.call();
    } else {
      emit(state.copyWith(error: "invalidLightAdress".tr()));
      emit(state.copyWith(error: null));
    }
  }

  Future<bool> _verifyInputNip05() {
    final privateKey = LocalDatabase.instance.getPrivateKey();
    if (privateKey == null) {
      return Future.value(false);
    }

    final pubKey =
        Nostr.instance.keysService.derivePublicKey(privateKey: privateKey);
    final internetIdentifier = nip05Controller?.text ?? '';

    final isValidNIP05 = Nostr.instance.utilsService
        .isValidNip05Identifier(nip05Controller?.text ?? '');

    if (nip05Controller!.text.isNotEmpty && isValidNIP05) {
      return Nostr.instance.utilsService.verifyNip05(
        internetIdentifier: internetIdentifier,
        pubKey: pubKey,
      );
    } else {
      return Future.value(false);
    }
  }

  void _updateCurrentUserProfileWithNip05(UserMetaData previousUserMetaData) {
    NostrService.instance.send.setCurrentUserMetaData(
      metadata: UserMetaData(
        name: previousUserMetaData.name,
        picture: previousUserMetaData.picture,
        banner: previousUserMetaData.banner,
        username: previousUserMetaData.username,
        about: previousUserMetaData.about,
        nip05Identifier: nip05Controller?.text,
      ),
    );
  }

  void _init() {
    nip05Controller = TextEditingController();

    currentUserMetadataSubscription =
        currentUserMetadata.stream.listen((event) {
      if(event.content == null) {
      debugPrint("No content in event");
        return;
      }

      final decoded = jsonDecode(event.content!) as Map<String, dynamic>;
      final metadata = UserMetaData.fromJson(
        jsonData: decoded,
        sourceNostrEvent: event,
      );

      emit(state.copyWith(currentUserMetadata: metadata));
    });
  }
}

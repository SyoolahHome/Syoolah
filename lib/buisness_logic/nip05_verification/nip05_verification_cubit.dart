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

class Nip05VerificationCubit extends Cubit<Nip05VerificationState> {
  TextEditingController? nip05Controller;
  NostrEventsStream currentUserMetadata;

  Nip05VerificationCubit({
    required this.currentUserMetadata,
  }) : super(Nip05VerificationInitial()) {
    _init();
  }

  @override
  Future<void> close() {
    nip05Controller?.dispose();

    return super.close();
  }

  Future<void> handleNip05Verification({
    required VoidCallback onSuccess,
  }) async {
    bool isVerified = await verifyInputNip05();
    final currentUserMetadata = state.currentUserMetadata;

    if (isVerified &&
        nip05Controller!.text.isNotEmpty &&
        currentUserMetadata != null) {
      _updateCurrentUserProfileWithNip05(state.currentUserMetadata!);
    } else {
      emit(state.copyWith(error: "invalidLightAdress".tr()));
      emit(state.copyWith(error: null));
    }
  }

  Future<bool> verifyInputNip05() {
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
      return Nostr.instance.relaysService.verifyNip05(
        internetIdentifier: internetIdentifier,
        pubKey: pubKey,
      );
    } else {
      return Future.value(false);
    }
  }

  void _updateCurrentUserProfileWithNip05(UserMetaData previousUserMetaData) {
    NostrService.instance.setCurrentUserMetaData(
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
    currentUserMetadata.stream.listen((event) {
      UserMetaData metadata = UserMetaData.fromJson(
        jsonDecode(event.content) as Map<String, dynamic>,
      );

      emit(state.copyWith(currentUserMetadata: metadata));
    });
  }
}

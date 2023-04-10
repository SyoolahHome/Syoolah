import 'package:bloc/bloc.dart';
import 'package:ditto/constants/strings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nostr_client/nostr/core/key_pairs.dart';

import '../../model/user_meta_data.dart';
import '../../services/database/local/local.dart';
import '../../services/nostr/nostr.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  TextEditingController? nameController;
  TextEditingController? existentKeyController;

  FocusNode? nameFocusNode;

  AuthCubit() : super(const AuthInitial()) {
    nameController = TextEditingController();
    existentKeyController = TextEditingController();
    nameFocusNode = FocusNode();
  }

  Future<void> authenticate() async {
    try {
      await _generatePrivateKeyAndSetInfoToNostr();
      NostrService.instance.setCurrentUserMetaData(
        metadata: UserMetaData(
          name: nameController!.text,
          username: nameController!.text,
          picture: null,
          banner: null,
          about: null,
        ),
      );
      emit(state.copyWith(authenticated: true));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(const AuthInitial());
    }
  }

  Future<void> _generatePrivateKeyAndSetInfoToNostr() async {
    emit(state.copyWith(isGeneratingNewPrivateKey: true));
    if (nameController!.text.isEmpty) {
      emit(const AuthInitial());
      throw AppStrings.pleaseEnterName;
    }

    final newGeneratedPair = NostrKeyPairs.generate();
    final privateKey = newGeneratedPair.private;

    await LocalDatabase.instance.setAuthInformations(
      key: privateKey,
      name: nameController!.text,
    );

    emit(state.copyWith(isGeneratingNewPrivateKey: false));
  }

  @override
  Future<void> close() {
    nameController?.dispose();
    nameFocusNode?.dispose();
    existentKeyController?.dispose();
    return super.close();
  }

  Future<void> handleExistentKey() async {
    if (existentKeyController!.text.isEmpty) {
      emit(state.copyWith(error: AppStrings.pleaseEnterKey));
      emit(const AuthInitial());

      return;
    }

    try {
      final keyChain = NostrKeyPairs(private: existentKeyController!.text);
      LocalDatabase.instance.setPrivateKey(keyChain.private);
      emit(state.copyWith(authenticated: true));
    } catch (e) {
      emit(state.copyWith(error: AppStrings.invalidKey));
      emit(const AuthInitial());

      return;
    } finally {
      emit(const AuthInitial());
    }
  }

  void signOut() {
    LocalDatabase.instance.setPrivateKey(null);
    emit(state.copyWith(isSignedOut: true));
  }

  void copyPrivateKey() {
    try {
      Clipboard.setData(
        ClipboardData(text: LocalDatabase.instance.getPrivateKey()),
      );
    } catch (e) {
      emit(state.copyWith(error: AppStrings.couldNotCopyKey));
    }
  }
}

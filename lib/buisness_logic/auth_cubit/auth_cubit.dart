import 'package:bloc/bloc.dart';
import 'package:ditto/constants/strings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:nostr/nostr.dart';

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

  void authenticate() async {
    try {
      await generatePrivateKey();
      await NostrService.instance.init();
      NostrService.instance.setCurrentUserMetaData(
        name: nameController!.text,
        creationDate: DateTime.now(),
      );
      emit(state.copyWith(authenticated: true));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(const AuthInitial());
    }
  }

  Future<void> generatePrivateKey() async {
    emit(state.copyWith(
      isGeneratingNewPrivateKey: true,
    ));
    if (nameController!.text.isEmpty) {
      emit(state.copyWith(error: AppStrings.pleaseEnterName));
      emit(const AuthInitial());

      return;
    }

    emit(state.copyWith(isGeneratingNewPrivateKey: true));
    final privateKey = NostrService.instance.generateKeys();

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

  handleExistentKey() async {
    if (existentKeyController!.text.isEmpty) {
      emit(state.copyWith(error: AppStrings.pleaseEnterKey));
      emit(const AuthInitial());

      return;
    }

    try {
      final keyChain = Keychain(existentKeyController!.text);
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

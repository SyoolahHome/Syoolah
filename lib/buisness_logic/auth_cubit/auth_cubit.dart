import 'package:bloc/bloc.dart';
import 'package:ditto/constants/strings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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

  Future<void> generatePrivateKey() async {
    if (nameController!.text.isEmpty) {
      emit(state.copyWith(error: AppStrings.pleaseEnterName));
      emit(const AuthInitial());

      return;
    }

    emit(state.copyWith(
      isGeneratingNewPrivateKey: true,
      error: null,
    ));
    final privateKey = NostrService.instance.generateKeys();

    await LocalDatabase.instance.setAuthInformations(
      key: privateKey,
      name: nameController!.text,
    );

    emit(state.copyWith(
      isGeneratingNewPrivateKey: false,
      shouldRedirectAfterGeneratingPrivateKey: true,
    ));

    emit(const AuthInitial());
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
      emit(state.copyWith(shouldRedirectDirectly: true));
    } catch (e) {
      emit(state.copyWith(error: AppStrings.invalidKey));
      emit(const AuthInitial());

      return;
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:ditto/constants/strings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../services/database/local/local.dart';
import '../../services/nostr/nostr.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  TextEditingController? nameController;
  FocusNode? nameFocusNode;
  AuthCubit() : super(const AuthInitial()) {
    nameController = TextEditingController();
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
    return super.close();
  }
}

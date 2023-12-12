import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'lnd_state.dart';

class LndCubit extends Cubit<LndState> {
  TextEditingController? usernameController;

  final server = "https://2b35-102-101-252-112.ngrok-free.app";

  LndCubit() : super(LndInitial()) {
    _init();
  }

  Future<void> close() {
    usernameController?.dispose();

    return super.close();
  }

  void onCreateAdressClick(BuildContext context) {
    BottomSheetService.createLndAddress(this, context);
  }

  _init() {
    usernameController = TextEditingController()
      ..addListener(() {
        emit(state.copyWith(username: usernameController!.text));
      });
  }

  void createAddress({
    required Null Function() onSuccess,
  }) async {
    final privateKey = LocalDatabase.instance.getPrivateKey()!;
    final derivedPublicKey = Nostr.instance.keysService.derivePublicKey(
      privateKey: privateKey,
    );
    try {
      emit(state.copyWith(isLoading: true));
      await _createLndAddress(derivedPublicKey);
      onSuccess();
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _createLndAddress(String userPubkey) async {}

  void loadUser(String userPubkey, String userData) {}
}

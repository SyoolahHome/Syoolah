import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'npub_cash_claim_username_state.dart';

class NpubCashClaimUsernameCubit extends Cubit<NpubCashClaimUsernameState> {
  NpubCashClaimUsernameCubit() : super(NpubCashClaimUsernameInitial()) {
    _init();
  }

  late final TextEditingController controller;

  void _init() {
    controller = TextEditingController()
      ..addListener(() {
        emit(state.copyWith(username: controller.text));
      });
  }

  @override
  Future<void> close() {
    controller.dispose();

    return super.close();
  }
}

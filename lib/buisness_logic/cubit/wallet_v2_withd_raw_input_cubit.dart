import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'wallet_v2_withd_raw_input_state.dart';

class WalletV2WithdRawInputCubit extends Cubit<WalletV2WithdRawInputState> {
  WalletV2WithdRawInputCubit() : super(WalletV2WithdRawInputInitial()) {
    _init();
  }

  late final TextEditingController inputController;

  void _init() {
    inputController = TextEditingController();
  }

  Future<void> close() async {
    inputController.dispose();

    return super.close();
  }
}

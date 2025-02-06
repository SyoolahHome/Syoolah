import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'mint_url_prompt_state.dart';

class MintUrlPromptCubit extends Cubit<MintUrlPromptState> {
  final String? defaultMint;
  MintUrlPromptCubit({
    this.defaultMint,
  }) : super(MintUrlPromptInitial()) {
    _init();
  }

  late final TextEditingController controller;

  void _init() {
    controller = TextEditingController()
      ..addListener(() {
        emit(state.copyWith(mintInput: controller.text));
      });

    controller.text = defaultMint ?? "";
  }

  @override
  Future<void> close() {
    controller.dispose();

    return super.close();
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'lnd_username_state.dart';

class LndUsernameCubit extends Cubit<LndUsernameState> {
  late final TextEditingController usernameController;

  LndUsernameCubit() : super(LndUsernameInitial()) {
    _init();
  }

  void _init() {
    usernameController = TextEditingController()
      ..text = "anas ${DateTime.now().millisecondsSinceEpoch}";
  }

  void onUsernameSubmitted() {
    final username = usernameController.text;

// TODO!
    final isValid = username.isNotEmpty;

    if (isValid) {
      emit(state.copyWith(isValid: isValid));
    } else {
      emit(state.copyWith(
        isValid: isValid,
        error: "Please enter a valid username",
      ));
    }
  }

  Future<void> close() {
    usernameController.dispose();

    return super.close();
  }
}

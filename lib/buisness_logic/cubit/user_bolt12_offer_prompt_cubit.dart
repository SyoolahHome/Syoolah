import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'user_bolt12_offer_prompt_state.dart';

class UserBolt12OfferPromptCubit extends Cubit<UserBolt12OfferPromptState> {
  late final TextEditingController bolt12InputController;

  UserBolt12OfferPromptCubit() : super(UserBolt12OfferPromptInitial());

  void _input() {
    bolt12InputController = TextEditingController()
      ..addListener(() {
        final bolt12Input = bolt12InputController.text;

        emit(state.copyWith(bolt12Input: bolt12Input));
      });
  }

  @override
  Future<void> close() {
    bolt12InputController.dispose();

    return super.close();
  }
}

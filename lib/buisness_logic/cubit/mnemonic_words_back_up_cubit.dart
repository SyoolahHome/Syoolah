import 'package:bloc/bloc.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'mnemonic_words_back_up_state.dart';

class MnemonicWordsBackUpCubit extends Cubit<MnemonicWordsBackUpState> {
  Map<String, TextEditingController> controllers = {};

  MnemonicWordsBackUpCubit({
    required String mnemonic,
  }) : super(MnemonicWordsBackUpInitial(
          mnemonicWords: mnemonic.split(' '),
        )) {
    _init();
  }

  void _init() {
    print(state.mnemonicWords.indexed
        .map((e) => "${e.$1 + 1}.${e.$2}, ")
        .toList());

    final mnemonicWords = state.mnemonicWords;

    for (var i = 0; i < mnemonicWords.length; i++) {
      final controller = TextEditingController();
      controller.text = mnemonicWords[i].showOnlyFirstChars(2);
      controllers[mnemonicWords[i]] = controller;
    }
  }

  @override
  Future<void> close() {
    controllers.forEach((key, value) {
      value.dispose();
    });

    return super.close();
  }

  void toggleVisibility(int index) {
    final word = state.mnemonicWords[index];
    final controller = controllers[word];

    final visibleWords = [
      ...state.visibleWords,
    ];

    if (visibleWords.contains(word)) {
      visibleWords.remove(word);
      controller!.text = word.showOnlyFirstChars(2);
    } else {
      visibleWords.add(word);
      controller!.text = word;
    }

    emit(state.copyWith(visibleWords: visibleWords));
  }

  void toggleAllVisibility(bool allShown) {
    if (allShown) {
      emit(state.copyWith(visibleWords: []));
      controllers.forEach((key, value) {
        value.text = key.showOnlyFirstChars(2);
      });
    } else {
      emit(state.copyWith(visibleWords: state.mnemonicWords));

      controllers.forEach((key, value) {
        value.text = key;
      });
    }
  }

  void startConfirmationProcess() {
    emit(state.copyWith(visibleWords: []));

    controllers.forEach((key, controller) {
      controller.text = key.showOnlyFirstChars(2);
    });

    emit(state.copyWith(isConfirmationProcessStarted: true));

    final fourRandomWords = state.mnemonicWords.shuffleAndGetNRandom(4);

    for (var i = 0; i < fourRandomWords.length; i++) {
      final word = fourRandomWords[i];

      final controller = controllers[fourRandomWords[i]];

      controller!.text = "";

      controller.addListener(() {
        final writtenInput = controller.text.trim();

        if (writtenInput == word) {
          emit(state.copyWith(
            randomWordsToInputManually: [...state.randomWordsToInputManually]
              ..remove(word),
          ));
        }
      });
    }

    emit(state.copyWith(
      randomWordsToInputManually: fourRandomWords,
    ));
  }
}

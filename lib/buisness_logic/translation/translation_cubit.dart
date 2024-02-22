import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ditto/model/bottom_sheet_option.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/tts/tts.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../model/translation_lang.dart';
import '../../services/open_ai/openai.dart';
import '../../services/translator/translator.dart';

part 'translation_state.dart';

class TranslationCubit extends Cubit<TranslationState> {
  late final TextEditingController inputController;
  late final TextEditingController outputController;

  TranslationCubit()
      : super(TranslationInitial(
          inputText: "",
          selectedTargetLang: TranslationLang.defaultLang,
        )) {
    _init();
  }

  void _init() {
    inputController = TextEditingController()
      ..addListener(() {
        emit(state.copyWith(
          inputText: inputController.text,
        ));
      });
    outputController = TextEditingController();
  }

  Future<void> applyTranslation() async {
    try {
      outputController.text = "";

      emit(state.copyWith(
        isLoading: true,
        error: null,
        translatedText: null,
        inputText: null,
      ));

      final translatedText = await Translator.translate(
        text: state.inputText,
        targetLang: state.selectedTargetLang.code,
      );

      outputController.text = translatedText;

      await Future.delayed(Duration(milliseconds: 100));

      emit(state.copyWith(
        isLoading: false,
        translatedText: translatedText,
      ));
    } catch (e) {
      debugPrint(e.toString());

      emit(state.copyWith(
        isLoading: false,
        error: "error".tr(),
      ));
    }
  }

  void copyInput() {
    final text = state.inputText;

    AppUtils.instance.copy(text);
  }

  void copyOutput() {
    final text = state.translatedText;

    if (text.isNotEmpty) {
      AppUtils.instance.copy(text);
    }
  }

  void openLangSelection(
    BuildContext context, {
    required void Function(TranslationLang lang) onLangSelected,
  }) async {
    final result = await BottomSheetService.showLangSelection(
      context,
      initialLang: state.selectedTargetLang,
    );

    if (result != null && result != state.selectedTargetLang) {
      emit(state.copyWith(selectedTargetLang: result));

      onLangSelected(result);
    }
  }

  void clearInput() {
    inputController.clear();
    outputController.clear();

    emit(state.copyWith(
      error: null,
      inputText: null,
      isLoading: false,
      langsLoaderReady: state.langsLoaderReady,
      selectedTargetLang: state.selectedTargetLang,
      speakingInput: false,
      speakingOutput: false,
      translatedText: "",
    ));
  }

  Future<void> speakInput(BuildContext Function() context) async {
    try {
      emit(state.copyWith(
        speakingInput: true,
      ));

      final inputText = state.inputText;

      await TTS.speak(
        text: inputText,
        context: context(),
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        error: "error".tr(),
      ));
    } finally {
      emit(state.copyWith(
        speakingInput: false,
      ));
    }
  }

  void speakOutput(
    BuildContext Function() context,
  ) async {
    try {
      emit(state.copyWith(
        speakingOutput: true,
      ));

      final outputText = state.translatedText;

      await TTS.speak(
        text: outputText,
        context: context(),
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(
        error: "error".tr(),
      ));
    } finally {
      emit(state.copyWith(
        speakingOutput: false,
      ));
    }
  }

  void shareAsNote(BuildContext context) async {
    await BottomSheetService.showCreatePostBottomSheet(
      context,
      initialNoteContent: state.translatedText,
    );
  }
}

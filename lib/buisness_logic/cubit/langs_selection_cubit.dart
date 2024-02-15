import 'package:bloc/bloc.dart';
import 'package:ditto/model/translation_lang.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'langs_selection_state.dart';

class LangsSelectionCubit extends Cubit<LangsSelectionState> {
  late final TextEditingController searchController;

  late final ScrollController scrollController;

  final List<TranslationLang> langs;

  LangsSelectionCubit({
    required TranslationLang? initial,
    required this.langs,
  }) : super(LangsSelectionInitial(
          selectedLang: initial ?? TranslationLang.defaultLang,
        )) {
    _init();
  }

  void _init() {
    searchController = TextEditingController()
      ..addListener(() {
        emit(state.copyWith(searchQuery: searchController.text));
      });

    scrollController = ScrollController();
  }

  void selectLang(
    TranslationLang lang,
    void Function(TranslationLang) onSelected,
  ) {
    emit(state.copyWith(selectedLang: lang));

    Future.delayed(Duration(milliseconds: 200), () {
      onSelected(lang);
    });
  }

  @override
  Future<void> close() {
    searchController.dispose();
    scrollController.dispose();

    return super.close();
  }
}

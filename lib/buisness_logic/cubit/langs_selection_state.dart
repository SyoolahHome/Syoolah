part of 'langs_selection_cubit.dart';

class LangsSelectionState extends Equatable {
  const LangsSelectionState({
    required this.selectedLang,
    required this.searchQuery,
  });

  final TranslationLang selectedLang;
  final String searchQuery;
  @override
  List<Object?> get props => [
        selectedLang,
        searchQuery,
      ];

  LangsSelectionState copyWith({
    TranslationLang? selectedLang,
    String? searchQuery,
  }) {
    return LangsSelectionState(
      selectedLang: selectedLang ?? this.selectedLang,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class LangsSelectionInitial extends LangsSelectionState {
  LangsSelectionInitial({
    required super.selectedLang,
    super.searchQuery = "",
  });
}

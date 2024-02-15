part of 'translation_cubit.dart';

class TranslationState extends Equatable {
  const TranslationState({
    required this.isLoading,
    required this.error,
    required this.translatedText,
    required this.inputText,
    required this.selectedTargetLang,
    required this.langsLoaderReady,
    this.speakingOutput = false,
    this.speakingInput = false,
  });

  final bool isLoading;
  final String? error;
  final String inputText;
  final String translatedText;
  final TranslationLang selectedTargetLang;
  final bool langsLoaderReady;
  final bool speakingOutput;
  final bool speakingInput;
  @override
  List<Object?> get props => [
        isLoading,
        error,
        translatedText,
        inputText,
        selectedTargetLang,
        langsLoaderReady,
        speakingOutput,
        speakingInput,
      ];

  TranslationState copyWith({
    bool? isLoading,
    String? error,
    String? translatedText,
    String? inputText,
    TranslationLang? selectedTargetLang,
    bool? langsLoaderReady,
    bool? speakingOutput,
    bool? speakingInput,
  }) {
    return TranslationState(
      selectedTargetLang: selectedTargetLang ?? this.selectedTargetLang,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      translatedText: translatedText ?? this.translatedText,
      inputText: inputText ?? this.inputText,
      langsLoaderReady: langsLoaderReady ?? this.langsLoaderReady,
      speakingOutput: speakingOutput ?? this.speakingOutput,
      speakingInput: speakingInput ?? this.speakingInput,
    );
  }
}

class TranslationInitial extends TranslationState {
  TranslationInitial({
    required super.inputText,
    required super.selectedTargetLang,
    super.isLoading = false,
    super.error,
    super.translatedText = "",
    super.langsLoaderReady = false,
  });
}

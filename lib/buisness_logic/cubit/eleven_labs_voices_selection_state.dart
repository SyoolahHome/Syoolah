part of 'eleven_labs_voices_selection_cubit.dart';

class ElevenLabsVoicesSelectionState extends Equatable {
  final List<TtsVoice>? voices;
  final bool isLoading;
  final String? error;

  const ElevenLabsVoicesSelectionState({
    this.isLoading = false,
    this.voices,
    this.error,
  });

  @override
  List<Object?> get props => [
        voices,
        isLoading,
        error,
      ];

  ElevenLabsVoicesSelectionState copyWith({
    List<TtsVoice>? voices,
    bool? isLoading,
    String? error,
  }) {
    return ElevenLabsVoicesSelectionState(
      isLoading: isLoading ?? this.isLoading,
      voices: voices ?? this.voices,
      error: error,
    );
  }
}

class ElevenLabsVoicesSelectionInitial extends ElevenLabsVoicesSelectionState {}

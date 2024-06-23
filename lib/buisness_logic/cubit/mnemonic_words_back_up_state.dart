part of 'mnemonic_words_back_up_cubit.dart';

class MnemonicWordsBackUpState extends Equatable {
  const MnemonicWordsBackUpState({
    required this.mnemonicWords,
    this.visibleWords = const [],
    this.isConfirmationProcessStarted = false,
    this.randomWordsToInputManually = const [],
  });

  final List<String> mnemonicWords;
  final List<String> visibleWords;
  final bool isConfirmationProcessStarted;
  final List<String> randomWordsToInputManually;

  @override
  List<Object?> get props => [
        mnemonicWords,
        visibleWords,
        isConfirmationProcessStarted,
        randomWordsToInputManually,
      ];

  MnemonicWordsBackUpState copyWith({
    List<String>? mnemonicWords,
    List<String>? visibleWords,
    List<String>? randomWordsToInputManually,
    bool? isConfirmationProcessStarted,
  }) {
    return MnemonicWordsBackUpState(
      mnemonicWords: mnemonicWords ?? this.mnemonicWords,
      visibleWords: visibleWords ?? this.visibleWords,
      isConfirmationProcessStarted:
          isConfirmationProcessStarted ?? this.isConfirmationProcessStarted,
      randomWordsToInputManually:
          randomWordsToInputManually ?? this.randomWordsToInputManually,
    );
  }
}

final class MnemonicWordsBackUpInitial extends MnemonicWordsBackUpState {
  MnemonicWordsBackUpInitial({
    required super.mnemonicWords,
  });
}

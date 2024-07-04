part of 'seed_phrase_prompt_and_private_key_deriver_cubit.dart';

class SeedPhrasePromptAndPrivateKeyDeriverState extends Equatable {
  const SeedPhrasePromptAndPrivateKeyDeriverState({
    this.error,
    this.privateKey,
  });

  final String? error;
  final String? privateKey;

  @override
  List<Object?> get props => [
        error,
        privateKey,
      ];

  SeedPhrasePromptAndPrivateKeyDeriverState copyWith({
    String? error,
    String? privateKey,
  }) {
    return SeedPhrasePromptAndPrivateKeyDeriverState(
      error: error,
      privateKey: privateKey ?? this.privateKey,
    );
  }
}

final class SeedPhrasePromptAndPrivateKeyDeriverInitial
    extends SeedPhrasePromptAndPrivateKeyDeriverState {}

part of 'mint_url_prompt_cubit.dart';

class MintUrlPromptState extends Equatable {
  const MintUrlPromptState({
    this.mintInput,
  });

  final String? mintInput;

  @override
  List<Object?> get props => [
        mintInput,
      ];

  MintUrlPromptState copyWith({
    String? mintInput,
  }) {
    return MintUrlPromptState(
      mintInput: mintInput ?? this.mintInput,
    );
  }
}

final class MintUrlPromptInitial extends MintUrlPromptState {}

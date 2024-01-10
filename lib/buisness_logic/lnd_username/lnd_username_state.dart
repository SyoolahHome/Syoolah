part of 'lnd_username_cubit.dart';

class LndUsernameState extends Equatable {
  final bool isValid;

  final String? error;

  const LndUsernameState({
    required this.isValid,
    this.error,
  });

  @override
  List<Object?> get props => [
        isValid,
        error,
      ];

  LndUsernameState copyWith({
    bool? isValid,
    String? error,
  }) {
    return LndUsernameState(
      isValid: isValid ?? this.isValid,
      error: error,
    );
  }
}

final class LndUsernameInitial extends LndUsernameState {
  LndUsernameInitial({
    super.isValid = false,
  });
}

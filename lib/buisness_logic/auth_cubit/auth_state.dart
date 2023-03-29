part of 'auth_cubit.dart';

@immutable
class AuthState extends Equatable {
  final bool isGeneratingNewPrivateKey;
  final bool shouldRedirectAfterGeneratingPrivateKey;
  final String? error;

  const AuthState({
    required this.isGeneratingNewPrivateKey,
    required this.shouldRedirectAfterGeneratingPrivateKey,
    this.error,
  });

  @override
  List<Object?> get props => [
        isGeneratingNewPrivateKey,
        shouldRedirectAfterGeneratingPrivateKey,
        error,
      ];

  AuthState copyWith({
    bool? isGeneratingNewPrivateKey,
    bool? shouldRedirectAfterGeneratingPrivateKey,
    String? error,
  }) {
    return AuthState(
      isGeneratingNewPrivateKey:
          isGeneratingNewPrivateKey ?? this.isGeneratingNewPrivateKey,
      shouldRedirectAfterGeneratingPrivateKey:
          shouldRedirectAfterGeneratingPrivateKey ??
              this.shouldRedirectAfterGeneratingPrivateKey,
      error: error ?? this.error,
    );
  }
}

class AuthInitial extends AuthState {
  const AuthInitial({
    super.isGeneratingNewPrivateKey = false,
    super.shouldRedirectAfterGeneratingPrivateKey = false,
  });
}

part of 'auth_cubit.dart';

@immutable
class AuthState extends Equatable {
  final bool authenticated;
  final String? error;
  final bool isGeneratingNewPrivateKey;
  final bool isSavingExistentKey;
  final bool isSignedOut;

  const AuthState({
    this.error,
    this.authenticated = false,
    this.isGeneratingNewPrivateKey = false,
    this.isSavingExistentKey = false,
    this.isSignedOut = false,
  });

  @override
  List<Object?> get props => [
        error,
        authenticated,
        isGeneratingNewPrivateKey,
        isSavingExistentKey,
        isSignedOut,
      ];

  AuthState copyWith({
    bool? isGeneratingNewPrivateKey,
    bool? shouldRedirectAfterGeneratingPrivateKey,
    String? error,
    bool? isSavingExistentKey,
    bool? authenticated,
    bool? isSignedOut,
  }) {
    return AuthState(
      error: error ?? this.error,
      authenticated: authenticated ?? this.authenticated,
      isGeneratingNewPrivateKey:
          isGeneratingNewPrivateKey ?? this.isGeneratingNewPrivateKey,
      isSavingExistentKey: isSavingExistentKey ?? this.isSavingExistentKey,
      isSignedOut: isSignedOut ?? this.isSignedOut,
    );
  }
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

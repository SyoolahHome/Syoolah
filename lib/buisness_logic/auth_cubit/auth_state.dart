part of 'auth_cubit.dart';

@immutable
class AuthState extends Equatable {
  final bool authenticated;
  final String? error;
  final bool isGeneratingNewPrivateKey;
  final bool isSavingExistentKey;

  const AuthState({
    this.error,
    this.authenticated = false,
    this.isGeneratingNewPrivateKey = false,
    this.isSavingExistentKey = false,
  });

  @override
  List<Object?> get props => [
        error,
        authenticated,
        isGeneratingNewPrivateKey,
        isSavingExistentKey,
         
      ];

  AuthState copyWith({
    bool? isGeneratingNewPrivateKey,
    bool? shouldRedirectAfterGeneratingPrivateKey,
    String? error,
    bool? isSavingExistentKey,
    bool? authenticated,
  }) {
    return AuthState(
      error: error ?? this.error,
      authenticated: authenticated ?? this.authenticated,
      isGeneratingNewPrivateKey:
          isGeneratingNewPrivateKey ?? this.isGeneratingNewPrivateKey,
      isSavingExistentKey: isSavingExistentKey ?? this.isSavingExistentKey,
    );
  }
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

part of 'auth_cubit.dart';

@immutable
class AuthState extends Equatable {
  final bool isGeneratingNewPrivateKey;
  final bool shouldRedirectAfterGeneratingPrivateKey;
  final bool isSavingExistentKey;
  final bool shouldRedirectDirectly;
  final String? error;

  const AuthState({
    this.isGeneratingNewPrivateKey = false,
    this.shouldRedirectAfterGeneratingPrivateKey = false,
    this.isSavingExistentKey = false,
    this.error,
    this.shouldRedirectDirectly = false,
  });

  @override
  List<Object?> get props => [
        isGeneratingNewPrivateKey,
        shouldRedirectAfterGeneratingPrivateKey,
        error,
        isSavingExistentKey,
        shouldRedirectDirectly,
      ];

  AuthState copyWith({
    bool? isGeneratingNewPrivateKey,
    bool? shouldRedirectAfterGeneratingPrivateKey,
    String? error,
    bool? isSavingExistentKey,
    bool? shouldRedirectDirectly,
  }) {
    return AuthState(
      isGeneratingNewPrivateKey:
          isGeneratingNewPrivateKey ?? this.isGeneratingNewPrivateKey,
      shouldRedirectAfterGeneratingPrivateKey:
          shouldRedirectAfterGeneratingPrivateKey ??
              this.shouldRedirectAfterGeneratingPrivateKey,
      error: error ?? this.error,
      isSavingExistentKey: isSavingExistentKey ?? this.isSavingExistentKey,
      shouldRedirectDirectly:
          shouldRedirectDirectly ?? this.shouldRedirectDirectly,
    );
  }
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

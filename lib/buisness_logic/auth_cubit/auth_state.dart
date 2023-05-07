part of 'auth_cubit.dart';

@immutable
class AuthState extends Equatable {
  final bool authenticated;
  final String? error;
  final bool isGeneratingNewPrivateKey;
  final bool isSavingExistentKey;
  final bool isSignedOut;
  final int currentStepIndex;
  final File? pickedImage;

  @override
  List<Object?> get props => [
        error,
        currentStepIndex,
        authenticated,
        isGeneratingNewPrivateKey,
        isSavingExistentKey,
        isSignedOut,
        pickedImage,
      ];

  const AuthState({
    this.pickedImage,
    this.currentStepIndex = 1,
    this.error,
    this.authenticated = false,
    this.isGeneratingNewPrivateKey = false,
    this.isSavingExistentKey = false,
    this.isSignedOut = false,
  });

  AuthState copyWith({
    bool? isGeneratingNewPrivateKey,
    String? error,
    bool? isSavingExistentKey,
    bool? authenticated,
    bool? isSignedOut,
    int? currentStepIndex,
    File? pickedImage,
  }) {
    return AuthState(
      pickedImage: pickedImage ?? this.pickedImage,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
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

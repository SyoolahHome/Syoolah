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
  final String privateKey;

  @override
  List<Object?> get props => [
        error,
        currentStepIndex,
        authenticated,
        isGeneratingNewPrivateKey,
        isSavingExistentKey,
        isSignedOut,
        pickedImage,
        privateKey,
      ];

  const AuthState({
    this.pickedImage,
    this.currentStepIndex = 1,
    this.error,
    this.authenticated = false,
    this.isGeneratingNewPrivateKey = false,
    this.isSavingExistentKey = false,
    this.isSignedOut = false,
    this.privateKey = "",
  });

  AuthState copyWith({
    bool? isGeneratingNewPrivateKey,
    String? error,
    bool? isSavingExistentKey,
    bool? authenticated,
    bool? isSignedOut,
    int? currentStepIndex,
    File? pickedImage,
    String? privateKey,
  }) {
    return AuthState(
      pickedImage: pickedImage,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      error: error ?? this.error,
      authenticated: authenticated ?? this.authenticated,
      isGeneratingNewPrivateKey:
          isGeneratingNewPrivateKey ?? this.isGeneratingNewPrivateKey,
      isSavingExistentKey: isSavingExistentKey ?? this.isSavingExistentKey,
      isSignedOut: isSignedOut ?? this.isSignedOut,
      privateKey: privateKey ?? this.privateKey,
    );
  }
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

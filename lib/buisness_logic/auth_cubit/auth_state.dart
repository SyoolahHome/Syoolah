part of 'auth_cubit.dart';

@immutable
class AuthState extends Equatable {
  final bool authenticated;
  final String? error;
  final bool isGeneratingNewPrivateKey;
  final bool isSavingExistentKey;
  final bool isSignedOut;
  final List<SignUpStepView>? signUpScreens;
  final int currentStepIndex;
  final File? pickedImage;

  const AuthState({
    this.pickedImage,
    this.currentStepIndex = 1,
    required this.signUpScreens,
    this.error,
    this.authenticated = false,
    this.isGeneratingNewPrivateKey = false,
    this.isSavingExistentKey = false,
    this.isSignedOut = false,
  });

  @override
  List<Object?> get props => [
        error,
        currentStepIndex,
        authenticated,
        isGeneratingNewPrivateKey,
        isSavingExistentKey,
        isSignedOut,
        signUpScreens,
        pickedImage,
      ];

  AuthState copyWith({
    bool? isGeneratingNewPrivateKey,
    bool? shouldRedirectAfterGeneratingPrivateKey,
    String? error,
    bool? isSavingExistentKey,
    bool? authenticated,
    bool? isSignedOut,
    List<SignUpStepView>? signUpScreens,
    int? currentStepIndex,
    File? pickedImage,
  }) {
    return AuthState(
      pickedImage: pickedImage ?? this.pickedImage,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      signUpScreens: signUpScreens ?? this.signUpScreens,
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
  const AuthInitial({
    super.signUpScreens,
  });
}

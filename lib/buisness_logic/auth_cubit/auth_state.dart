part of 'auth_cubit.dart';

@immutable

/// {@template auth_state}
/// The state if [AuthCubit].
/// {@endtemplate}
class AuthState extends Equatable {
  /// Weither a user is authenticated.
  final bool authenticated;

  /// The error String if it exists
  final String? error;

  /// Weither is generaing anew Nostr key pair for the user.
  final bool isGeneratingNewPrivateKey;

  /// Weither it is saving the existent key for the user.
  final bool isSavingExistentKey;

  /// Weither the user is signed out.
  final bool isSignedOut;

  /// The current Sign up flow step's index.
  final int currentStepIndex;

  /// The picked image for the user avatar.
  final File? pickedImage;

  /// The generated private key for the user, since it is the source of all others.
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

  /// {@macro auth_state}
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

  /// {@macro auth_state}
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
      pickedImage: pickedImage ?? this.pickedImage,
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

  /// {@macro auth_state}
  factory AuthState.initial() {
    return AuthInitial();
  }

  /// {@macro auth_state}
  AuthState copyWithNullPickedImage() {
    return AuthState(
      pickedImage: null,
      currentStepIndex: currentStepIndex,
      error: error,
      authenticated: authenticated,
      isGeneratingNewPrivateKey: isGeneratingNewPrivateKey,
      isSavingExistentKey: isSavingExistentKey,
      isSignedOut: isSignedOut,
      privateKey: privateKey,
    );
  }
}

/// {@macro auth_state}
class AuthInitial extends AuthState {
  const AuthInitial();
}

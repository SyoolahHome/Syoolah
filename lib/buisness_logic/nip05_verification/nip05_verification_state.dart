part of 'nip05_verification_cubit.dart';

/// {@template nip_05_verification_state}
/// The state of [Nip05VerificationCubit]
/// {@endtemplate}
class Nip05VerificationState extends Equatable {
  /// An error if exists to be shown
  final String? error;

  /// The current user metadata that will be used to update the profile with the verified field marked.
  final UserMetaData? currentUserMetadata;

  /// {@macro nip_05_verification_state}
  const Nip05VerificationState({
    this.error,
    this.currentUserMetadata,
  });

  @override
  List<Object?> get props => [error, currentUserMetadata];

  /// {@macro nip_05_verification_state}
  Nip05VerificationState copyWith({
    String? error,
    UserMetaData? currentUserMetadata,
  }) {
    return Nip05VerificationState(
      error: error,
      currentUserMetadata: currentUserMetadata,
    );
  }

  /// {@macro nip_05_verification_state}
  factory Nip05VerificationState.initial() {
    return Nip05VerificationInitial();
  }
}

/// {@macro nip_05_verification_state}
class Nip05VerificationInitial extends Nip05VerificationState {}

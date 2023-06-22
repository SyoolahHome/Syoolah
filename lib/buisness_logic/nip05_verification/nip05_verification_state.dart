// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'nip05_verification_cubit.dart';

class Nip05VerificationState extends Equatable {
  final String? error;
  final UserMetaData? currentUserMetadata;

  const Nip05VerificationState({
    this.error,
    this.currentUserMetadata,
  });

  @override
  List<Object?> get props => [error, currentUserMetadata];

  Nip05VerificationState copyWith({
    String? error,
    UserMetaData? currentUserMetadata,
  }) {
    return Nip05VerificationState(
      error: error,
      currentUserMetadata: currentUserMetadata,
    );
  }
}

class Nip05VerificationInitial extends Nip05VerificationState {}

part of 'private_key_gen_success_cubit.dart';

/// {@template private_key_gen_success_state}
/// The state of [PrivateKeyGenSuccessCubit].
/// {@endtemplate}
class PrivateKeyGenSuccessState extends Equatable {
  /// Weither the passord is visible.
  final bool isPasswordVisible;

  /// The user private key.
  final String? privateKey;

  /// The user public key.
  final String? publicKey;

  /// THe user npub key.
  final String? nPubKey;

  /// The user nsec key.
  final String? nsecKey;

  @override
  List<Object?> get props => [
        isPasswordVisible,
        privateKey,
        publicKey,
        nPubKey,
        nsecKey,
      ];

  /// {@macro private_key_gen_success_state}
  const PrivateKeyGenSuccessState({
    this.isPasswordVisible = false,
    this.privateKey,
    this.publicKey,
    this.nPubKey,
    this.nsecKey,
  });

  /// {@macro private_key_gen_success_state}
  PrivateKeyGenSuccessState copyWith({
    bool? isPasswordVisible,
    String? privateKey,
    String? publicKey,
    String? nPubKey,
    String? nsecKey,
  }) {
    return PrivateKeyGenSuccessState(
      nPubKey: nPubKey ?? this.nPubKey,
      nsecKey: nsecKey ?? this.nsecKey,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      privateKey: privateKey ?? this.privateKey,
      publicKey: publicKey ?? this.publicKey,
    );
  }

  /// {@macro private_key_gen_success_state}
  factory PrivateKeyGenSuccessState.initial() {
    return PrivateKeyGenSuccessInitial();
  }
}

/// {@macro private_key_gen_success_state}
class PrivateKeyGenSuccessInitial extends PrivateKeyGenSuccessState {
  const PrivateKeyGenSuccessInitial({
    super.privateKey,
    super.publicKey,
    super.nPubKey,
    super.nsecKey,
  });
}

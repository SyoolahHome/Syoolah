part of 'private_key_gen_success_cubit.dart';

/// {@template private_key_gen_success_state}
/// The state of [PrivateKeyGenSuccessCubit].
/// {@endtemplate}
class PrivateKeyGenSuccessState extends Equatable {
  /// Weither the passord is visible.
  final bool isPrivateKeyVisible;

  /// Weither the mnemonic is visible.
  final bool isMnemonicVisible;

  ///
  final bool mnemonicBackedUp;

  /// The user private key.
  final String? privateKey;

  /// The user public key.
  final String? publicKey;

  /// THe user npub key.
  final String? nPubKey;

  /// The user nsec key.
  final String? nsecKey;

  ///
  final String? mnemonic;

  @override
  List<Object?> get props => [
        isPrivateKeyVisible,
        isMnemonicVisible,
        mnemonicBackedUp,
        privateKey,
        publicKey,
        nPubKey,
        nsecKey,
        mnemonic,
      ];

  /// {@macro private_key_gen_success_state}
  const PrivateKeyGenSuccessState({
    this.isPrivateKeyVisible = false,
    this.isMnemonicVisible = false,
    this.mnemonicBackedUp = false,
    this.privateKey,
    this.publicKey,
    this.nPubKey,
    this.nsecKey,
    this.mnemonic,
  });

  /// {@macro private_key_gen_success_state}
  PrivateKeyGenSuccessState copyWith({
    bool? isPrivateKeyVisible,
    String? privateKey,
    String? publicKey,
    String? nPubKey,
    String? nsecKey,
    String? mnemonic,
    bool? isMnemonicVisible,
    bool? mnemonicBackedUp,
  }) {
    return PrivateKeyGenSuccessState(
      nPubKey: nPubKey ?? this.nPubKey,
      nsecKey: nsecKey ?? this.nsecKey,
      isPrivateKeyVisible: isPrivateKeyVisible ?? this.isPrivateKeyVisible,
      privateKey: privateKey ?? this.privateKey,
      publicKey: publicKey ?? this.publicKey,
      mnemonic: mnemonic ?? this.mnemonic,
      isMnemonicVisible: isMnemonicVisible ?? this.isMnemonicVisible,
      mnemonicBackedUp: mnemonicBackedUp ?? this.mnemonicBackedUp,
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
    super.mnemonic,
  });
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'private_key_gen_success_cubit.dart';

class PrivateKeyGenSuccessState extends Equatable {
  final bool isPasswordVisible;
  final String? privateKey;
  final String? publicKey;
  final String? nPubKey;
  final String? nsecKey;

  @override
  List<Object?> get props => [
        isPasswordVisible,
        privateKey,
        publicKey,
        nPubKey,
        nsecKey,
      ];

  const PrivateKeyGenSuccessState({
    this.isPasswordVisible = false,
    this.privateKey,
    this.publicKey,
    this.nPubKey,
    this.nsecKey,
  });

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
}

class PrivateKeyGenSuccessInitial extends PrivateKeyGenSuccessState {
  const PrivateKeyGenSuccessInitial({
    super.privateKey,
    super.publicKey,
    super.nPubKey,
    super.nsecKey,
  });
}

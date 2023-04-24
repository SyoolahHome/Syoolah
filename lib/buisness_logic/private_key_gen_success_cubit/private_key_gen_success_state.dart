// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'private_key_gen_success_cubit.dart';

class PrivateKeyGenSuccessState extends Equatable {
  final bool isPasswordVisible;
  final String? privateKey;
  final String? publicKey;
  const PrivateKeyGenSuccessState({
    this.isPasswordVisible = false,
    this.privateKey,
    this.publicKey,
  });

  @override
  List<Object?> get props => [
        isPasswordVisible,
        privateKey,
        publicKey,
      ];

  PrivateKeyGenSuccessState copyWith({
    bool? isPasswordVisible,
    String? privateKey,
    String? publicKey,
  }) {
    return PrivateKeyGenSuccessState(
      publicKey: publicKey ?? this.publicKey,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      privateKey: privateKey ?? this.privateKey,
    );
  }
}

class PrivateKeyGenSuccessInitial extends PrivateKeyGenSuccessState {
  const PrivateKeyGenSuccessInitial({
    required super.privateKey,
    required super.publicKey,
  });
}

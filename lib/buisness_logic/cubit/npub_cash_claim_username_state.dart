part of 'npub_cash_claim_username_cubit.dart';

class NpubCashClaimUsernameState extends Equatable {
  const NpubCashClaimUsernameState({
     this.username,
  });

  final String? username;

  @override
  List<Object?> get props => [username];
  
  NpubCashClaimUsernameState copyWith({
    String? username,
  }) {
    return NpubCashClaimUsernameState(
      username: username ?? this.username,
    );
  }
}

final class NpubCashClaimUsernameInitial extends NpubCashClaimUsernameState {}

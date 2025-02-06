part of 'lnd_view_cubit.dart';

class LndViewState extends Equatable {
  const LndViewState({
    this.npub,
    this.balance,
    this.userInfo,
    this.balanceFetched = false,
    this.userInfoFetched = false,
    this.error,
    this.success,
  });

  final String? npub;
  final int? balance;
  final bool balanceFetched;
  final bool? userInfoFetched;
  final ECashUserInfo? userInfo;
  final String? error;
  final String? success;

  @override
  List<Object?> get props => [
        npub,
        balance,
        balanceFetched,
        userInfo,
        userInfoFetched,
        error,
        success,
      ];

  LndViewState copyWith({
    String? npub,
    int? balance,
    bool? balanceFetched,
    bool? userInfoFetched,
    ECashUserInfo? userInfo,
    String? error,
    String? success,
  }) {
    return LndViewState(
      npub: npub ?? this.npub,
      balance: balance ?? this.balance,
      balanceFetched: balanceFetched ?? this.balanceFetched,
      userInfo: userInfo ?? this.userInfo,
      userInfoFetched: userInfoFetched ?? this.userInfoFetched,
      error: error,
      success: success ?? this.success,
    );
  }
}

final class LndViewInitial extends LndViewState {}

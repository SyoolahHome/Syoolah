part of 'wallet_version_two_cubit.dart';

class WalletVersionTwoState extends Equatable {
  final String? walletServerBaseUrl;
  final bool isLoadingServer;
  final PhoenixDBalanceResponse? balance;
  final bool isLoadingBalance;
  final String? walletServerPassword;
  final String? bolt12Offer;
  final bool isLoadingBolt12Offer;
  final bool isReloadingAllRequests;
  final String? error;
  final bool isLoadingGeneratingBolt11Invoice;
  final bool isLoadingWithdraw;
  final bool isLoadingNodeInfo;
  final PhoenixDNodeInfo? nodeInfo;
  final String? bip353Identifier;
  final bool isBip353Loading;
  final bool allowApplyButtonForServer;

  const WalletVersionTwoState({
    this.walletServerBaseUrl,
    this.isLoadingServer = false,
    this.isLoadingBalance = false,
    this.isLoadingBolt12Offer = false,
    this.isReloadingAllRequests = false,
    this.balance,
    this.walletServerPassword,
    this.bolt12Offer,
    this.error,
    this.isLoadingGeneratingBolt11Invoice = false,
    this.isLoadingWithdraw = false,
    this.isLoadingNodeInfo = false,
    this.nodeInfo,
    this.bip353Identifier,
    this.isBip353Loading = false,
    this.allowApplyButtonForServer = false,
  });

  WalletVersionTwoState copyWith({
    String? walletServerBaseUrl,
    bool? isLoadingServer,
    bool? isLoadingBalance,
    bool? isLoadingBolt12Offer,
    PhoenixDBalanceResponse? balance,
    PhoenixDNodeInfo? nodeInfo,
    String? walletServerPassword,
    String? bolt12Offer,
    bool? isReloadingAllRequests,
    String? error,
    bool? isLoadingGeneratingBolt11Invoice,
    bool? isLoadingWithdraw,
    bool? isLoadingNodeInfo,
    String? bip353Identifier,
    bool? isBip353Loading,
    bool? allowApplyButtonForServer,
  }) {
    return WalletVersionTwoState(
      allowApplyButtonForServer:
          allowApplyButtonForServer ?? this.allowApplyButtonForServer,
      nodeInfo: nodeInfo ?? this.nodeInfo,
      walletServerBaseUrl: walletServerBaseUrl ?? this.walletServerBaseUrl,
      isLoadingServer: isLoadingServer ?? this.isLoadingServer,
      isLoadingBalance: isLoadingBalance ?? this.isLoadingBalance,
      balance: balance ?? this.balance,
      walletServerPassword: walletServerPassword ?? this.walletServerPassword,
      bolt12Offer: bolt12Offer ?? this.bolt12Offer,
      isLoadingBolt12Offer: isLoadingBolt12Offer ?? this.isLoadingBolt12Offer,
      isReloadingAllRequests:
          isReloadingAllRequests ?? this.isReloadingAllRequests,
      error: error,
      isLoadingGeneratingBolt11Invoice: isLoadingGeneratingBolt11Invoice ??
          this.isLoadingGeneratingBolt11Invoice,
      isLoadingWithdraw: isLoadingWithdraw ?? this.isLoadingWithdraw,
      isLoadingNodeInfo: isLoadingNodeInfo ?? this.isLoadingNodeInfo,
      bip353Identifier: bip353Identifier ?? this.bip353Identifier,
      isBip353Loading: isBip353Loading ?? this.isBip353Loading,
    );
  }

  @override
  List<Object?> get props => [
        isLoadingServer,
        isLoadingBalance,
        balance,
        walletServerBaseUrl,
        walletServerPassword,
        bolt12Offer,
        isLoadingBolt12Offer,
        isReloadingAllRequests,
        error,
        isLoadingGeneratingBolt11Invoice,
        isLoadingWithdraw,
        isLoadingNodeInfo,
        nodeInfo,
        bip353Identifier,
        isBip353Loading,
        allowApplyButtonForServer,
      ];
}

final class WalletVersionTwoInitial extends WalletVersionTwoState {}

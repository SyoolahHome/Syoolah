part of 'wallet_two_history_cubit.dart';

class WalletTwoHistoryState extends Equatable {
  const WalletTwoHistoryState({
    this.isIncomingLoading = false,
    this.isOutgoingLoading = false,
    this.incomingPayments = const <PhoenixDIncomingPayment>[],
    this.outgoingPayments = const <PhoenixDOutgoingPayment>[],
    this.isAll = false,
  });

  final bool isIncomingLoading;
  final bool isOutgoingLoading;
  final List<PhoenixDIncomingPayment> incomingPayments;
  final List<PhoenixDOutgoingPayment> outgoingPayments;
  final bool isAll;

  @override
  List<Object?> get props => [
        isIncomingLoading,
        isOutgoingLoading,
        incomingPayments,
        outgoingPayments,
        isAll,
      ];

  WalletTwoHistoryState copyWith({
    bool? isIncomingLoading,
    bool? isOutgoingLoading,
    List<PhoenixDIncomingPayment>? incomingPayments,
    List<PhoenixDOutgoingPayment>? outgoingPayments,
    bool? isAll,
  }) {
    return WalletTwoHistoryState(
      isIncomingLoading: isIncomingLoading ?? this.isIncomingLoading,
      isOutgoingLoading: isOutgoingLoading ?? this.isOutgoingLoading,
      incomingPayments: incomingPayments ?? this.incomingPayments,
      outgoingPayments: outgoingPayments ?? this.outgoingPayments,
      isAll: isAll ?? this.isAll,
    );
  }
}

final class WalletTwoHistoryInitial extends WalletTwoHistoryState {}

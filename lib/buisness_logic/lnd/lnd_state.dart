part of 'lnd_cubit.dart';

class LndState extends Equatable {
  final String domain;
  final bool isLoading;
  final String? username;
  final String? lndAddress;
  final String? lnurl;
  final String? paycode;
  final List? relays;
  final String? relaysSig;
  final List<PendingPayment> pendingPayments;
  const LndState({
    required this.domain,
    required this.isLoading,
    this.username,
    this.lndAddress,
    this.lnurl,
    this.paycode,
    this.relays,
    this.relaysSig,
    this.pendingPayments = const [],
  });

  @override
  List<Object?> get props => [
        isLoading,
        username,
        lndAddress,
        lnurl,
        paycode,
        relays,
        relaysSig,
        pendingPayments,
      ];

  LndState copyWith({
    bool? isLoading,
    String? username,
    String? lndAddress,
    String? lnurl,
    String? paycode,
    List? relays,
    String? relaysSig,
    List<PendingPayment>? pendingPayments,
  }) {
    return LndState(
      domain: domain,
      isLoading: isLoading ?? this.isLoading,
      username: username ?? this.username,
      lndAddress: lndAddress ?? this.lndAddress,
      lnurl: lnurl ?? this.lnurl,
      paycode: paycode ?? this.paycode,
      relays: relays ?? this.relays,
      relaysSig: relaysSig ?? this.relaysSig,
      pendingPayments: pendingPayments ?? this.pendingPayments,
    );
  }
}

class LndInitial extends LndState {
  LndInitial({
    required super.domain,
    super.isLoading = false,
    super.username,
    super.lndAddress,
    super.lnurl,
    super.paycode,
    super.relays,
    super.relaysSig,
    super.pendingPayments = const [],
  });
}

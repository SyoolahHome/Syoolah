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
  final List<String>? loadingMessages;
  final bool shouldLoadUser;
  final bool shouldCreateUser;
  final Map<String, dynamic>? userData;

  const LndState({
    required this.domain,
    required this.isLoading,
    required this.pendingPayments,
    required this.shouldCreateUser,
    required this.shouldLoadUser,
    this.userData,
    this.username,
    this.lndAddress,
    this.lnurl,
    this.paycode,
    this.relays,
    this.relaysSig,
    this.loadingMessages,
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
        loadingMessages,
        shouldCreateUser,
        shouldLoadUser,
        userData,
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
    List<String>? loadingMessages,
    bool? shouldCreateUser,
    bool? shouldLoadUser,
    Map<String, dynamic>? userData,
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
      loadingMessages: loadingMessages ?? this.loadingMessages,
      shouldCreateUser: shouldCreateUser ?? this.shouldCreateUser,
      shouldLoadUser: shouldLoadUser ?? this.shouldLoadUser,
      userData: userData ?? this.userData,
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
    super.loadingMessages,
    super.shouldCreateUser = false,
    super.shouldLoadUser = false,
    super.userData,
  });
}

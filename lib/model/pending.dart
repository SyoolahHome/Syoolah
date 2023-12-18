import 'package:equatable/equatable.dart';

class PendingPayment extends Equatable {
  final amount;
  final swapFee;
  final miningFee;
  final amountExpected;
  final blocksTilExpiry;
  final String pmtHash;
  final String preimage;
  final String serverPubKey;
  final amountExpectedInSwapAddress;
  final amountExpectedLnurl;
  final bool v2;

  PendingPayment({
    required this.amount,
    required this.swapFee,
    required this.miningFee,
    required this.amountExpected,
    required this.blocksTilExpiry,
    required this.pmtHash,
    required this.preimage,
    required this.serverPubKey,
    required this.amountExpectedInSwapAddress,
    required this.amountExpectedLnurl,
    required this.v2,
  });

  @override
  List<Object?> get props => [
        amount,
        swapFee,
        miningFee,
        amountExpected,
        blocksTilExpiry,
        pmtHash,
        preimage,
        serverPubKey,
        amountExpectedInSwapAddress,
        amountExpectedLnurl,
        v2,
      ];
}

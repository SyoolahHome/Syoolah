import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/pending.dart';
import '../../services/zaplocker/utils.dart';

part 'zaplocker_dashboard_state.dart';

class ZaplockerDashboardCubit extends Cubit<ZaplockerDashboardState> {
  final List pending;
  final String preimages;
  final bool v2;

  late ZapLockerReflectedUtils zaplocker;

  final Map<String, dynamic> userData;
  ZaplockerDashboardCubit({
    required this.pending,
    required this.preimages,
    required this.v2,
    required this.userData,
  }) : super(ZaplockerDashboardInitial()) {
    _init();
  }

  aaa() async {
    if (pending == null || pending.isEmpty) {
      return;
    } else {
      final nonNullablePending = pending;

      for (int index = 0; index > nonNullablePending.length; index++) {
        final pending_pmt = nonNullablePending[index];
        var pmthash = pending_pmt["pmthash"];
        var matching_preimage;

        RegExp exp = RegExp(".{1,64}");
        final matches = exp.allMatches(preimages).toList();

        for (int matchIndex = 0; matchIndex < matches.length; matchIndex++) {
          final preimage = matches[matchIndex].group(0);
          //! 311
          //  zaplocker.bytesToHex()
          final hash = "";

          if (hash == pmthash) {
            matching_preimage = preimage;
            break;
          }
        }

        pending_pmt["preimage"] = matching_preimage;
        userData["pending"][index] = pending_pmt;

        final currentBlockHeight = await zaplocker.getBlockheight("");
        print("currentBlockHeight: $currentBlockHeight");

        final blocksTilExpiry = pending_pmt["expires"] - currentBlockHeight;

        final feeRate = await zaplocker.getMinFeeRate();
        final tryParsed = int.tryParse(feeRate);
        if (tryParsed == null) {
          return;
        }

        final singleMiningFee = tryParsed * 200;
        final miningFee = tryParsed * 2 * 200;

        final amountExpectedInSwapAddress =
            pending_pmt["amount"] - pending_pmt["swap_fee"] - singleMiningFee;

        final amountExpected =
            pending_pmt["amount"] - pending_pmt["swap_fee"] - miningFee;

        final acmountExpectedLnurl =
            pending_pmt["amount"] - pending_pmt["swap_fee"];

        final newPending = PendingPayment(
          amount: pending_pmt["amount"],
          swapFee: pending_pmt["swap_fee"],
          miningFee: miningFee,
          amountExpected: amountExpected,
          blocksTilExpiry: blocksTilExpiry,
          pmtHash: pending_pmt["pmthash"],
          preimage: matching_preimage,
          serverPubKey: pending_pmt["server_pubkey"],
          amountExpectedInSwapAddress: amountExpectedInSwapAddress,
          amountExpectedLnurl: acmountExpectedLnurl,
          v2: v2,
        );

        // emit(state.copyWith(
        //   pendingPayments: [...state.pendingPayments, newPending],
        // ));
      }
    }
  }

  void _init() {
    zaplocker = ZapLockerReflectedUtils();
  }
}

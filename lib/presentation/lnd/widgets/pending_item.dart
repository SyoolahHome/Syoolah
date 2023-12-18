import 'package:ditto/buisness_logic/lnd/lnd_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/pending.dart';
import 'attestaion_info.dart';

class PendingItem extends StatelessWidget {
  const PendingItem({
    super.key,
    required this.pending,
  });

  final PendingPayment pending;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LndCubit>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("${pending.amount} satoshis"),
        Text("${pending.swapFee} satoshis"),
        Text(
          "Mining fee (estimate -- only on the base layer): ${pending.miningFee} satoshis",
        ),
        Text(
          "Amount you'll get after fees (on the base layer): ${pending.amountExpected} satochis",
        ),
        Text(
          "Amount you'll get after fees (over lightning): ${pending.amountExpected + pending.miningFee} satochis",
        ),
        Text("Expires: ${pending.blocksTilExpiry * 10}"),
        // ...

        if (pending.v2)
          AttestationInfo(
            pmtHash: pending.pmtHash,
            amount: pending.amount,
            swapFee: pending.swapFee,
          ),
        ElevatedButton(
          onPressed: () {
            cubit.settleOnBaseLayer(
              context: context,
              pending: pending,
              onRequestContext: () => context,
            );
          },
          child: Text("Settle On Base Layer"),
        ),

        ElevatedButton(
          onPressed: () {
            cubit.settleOverLightning(
              context: context,
              pending: pending,
              onSettleError: () {
                print("error");
              },
              onSettleSuccess: () {
                print("success");
              },
              onUndefinedError: () {
                print("undefined error");
              },
            );
          },
          child: Text("Settle Over Lightning"),
        ),
      ],
    );
  }
}

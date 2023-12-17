import 'package:ditto/model/pending.dart';
import 'package:flutter/material.dart';

import 'pending_item.dart';

class PendingList extends StatelessWidget {
  const PendingList({
    super.key,
    required this.pendingPayments,
  });

  final List<PendingPayment> pendingPayments;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...pendingPayments.map(
          (pending) => PendingItem(pending: pending),
        ),
      ],
    );
  }
}

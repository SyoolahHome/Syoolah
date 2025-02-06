import 'package:ditto/model/pheonixD_payment.dart';
import 'package:flutter/material.dart';

class HistoryPaymentDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const HistoryPaymentDetailsAppBar({
    super.key,
    required this.payment,
  });

  final PhoenixDPayment payment;

  Widget build(BuildContext context) {
    return AppBar(
      //! maybe decodee it later
      title: Text(/*payment.invoice*/ ""),
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }
}

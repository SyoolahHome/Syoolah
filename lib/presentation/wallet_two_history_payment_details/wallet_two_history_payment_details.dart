import 'package:ditto/model/pheonixD_payment.dart';
import 'package:ditto/model/phoenixD_outgoing_payment.dart';
import 'package:ditto/model/phoenixd_incoming_payment.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/wallet_two_history_payment_details/widgets/app_bar.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:timeago/timeago.dart' as timeago;

class WalletTwoHistoryPaymentDetails extends StatelessWidget {
  const WalletTwoHistoryPaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final argsMap =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final payment = argsMap?["payment"] as PhoenixDPayment?;

    if (payment == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text("No payment information found for this transaction"),
        ),
      );
    }

    int? amountInSats;
    String? titleToShow;

    if (payment is PhoenixDOutgoingPayment) {
      amountInSats = payment.sent;
      titleToShow = "Outgoing\nPayment Details";
    } else if (payment is PhoenixDIncomingPayment) {
      amountInSats = payment.receivedSat;
      titleToShow = "Incoming\nPayment Details";
    }

    final generalFDetailsListRecs = <(String, String?)>[
      if (payment is PhoenixDOutgoingPayment)
        (
          "Payment ID",
          payment.paymentId,
        ),
      if (payment is PhoenixDIncomingPayment) ...[
        ("Description", payment.description ?? ""),
        if (payment.externalId != null) ("ID", payment.externalId!),
      ],
      (
        "Transaction Amount",
        amountInSats != null ? "$amountInSats Sat" : null,
      ),
      (
        "Creation Date",
        payment.createdAt != null
            ? DateFormat('yyyy-MM-dd – kk:mm')
                .format(DateTime.fromMillisecondsSinceEpoch(payment.createdAt!))
            : null
      ),
      (
        "Completion Date",
        payment.completedAt != null
            ? DateFormat('yyyy-MM-dd – kk:mm').format(
                DateTime.fromMillisecondsSinceEpoch(payment.completedAt!))
            : null
      ),
      (
        "Fees Amount",
        payment.fees != null ? "${payment.fees}" : null,
      ),
      (
        "isPaid",
        payment.isPaid != null ? "${payment.isPaid! ? 'yes' : 'no'}" : null,
      ),
      (
        "Invoice",
        payment.invoice != null ? "${payment.invoice}" : null,
      ),
      (
        "Payment Hash",
        payment.paymentHash != null ? "${payment.paymentHash}" : null,
      ),
      (
        "Payment Preimage",
        payment.preimage != null ? "${payment.preimage}" : null,
      ),
      (
        "Payment Preimage",
        payment.preimage != null ? "${payment.preimage}" : null,
      ),
    ];

    final heightSpace = 10.0;

    final isPaidAndCompleted =
        payment.completedAt != null && (payment.isPaid ?? false);

    return Scaffold(
      appBar: HistoryPaymentDetailsAppBar(
        payment: payment,
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: MarginedBody(
              child: Column(
                children: <Widget>[
                  SizedBox(height: heightSpace * 2),
                  if (titleToShow != null) ...[
                    Text(
                      titleToShow,
                      style:
                          Theme.of(context).textTheme.displaySmall?.copyWith(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: heightSpace * 2),
                  ],
                  Icon(
                    isPaidAndCompleted
                        ? FlutterRemix.checkbox_circle_line
                        : FlutterRemix.close_circle_line,
                    color: isPaidAndCompleted ? Colors.green[700] : Colors.red,
                    size: 100,
                  ),
                  SizedBox(height: heightSpace * 2),
                  ...generalFDetailsListRecs.map(
                    (infoRec) {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        subtitle: Text(
                          infoRec.$2 ?? "N/A",
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.color
                                        ?.withOpacity(.7),
                                  ),
                        ),
                        title: Text(
                          infoRec.$1,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    },
                  ),
                  if (payment.invoice != null &&
                      payment.invoice!.isNotEmpty) ...[
                    SizedBox(height: heightSpace * 2),
                    SizedBox(
                      width: double.infinity,
                      child: RoundaboutButton(
                        text: "Copy Invoice to Clipboard",
                        onTap: () {
                          AppUtils.instance.copy(
                            payment.invoice!,
                            onSuccess: () {
                              SnackBars.text(
                                context,
                                "Invoice copied to clipboard",
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                  SizedBox(height: heightSpace * 2),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

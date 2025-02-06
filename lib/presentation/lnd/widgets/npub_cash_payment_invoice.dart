import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/cubit/npub_cash_payment_invoice_cubit.dart';
import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/profile_options/widgets/profile_title.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class NpubCashPaymentInvoice extends StatelessWidget {
  const NpubCashPaymentInvoice({
    super.key,
    required this.invoice,
    required this.paymentToken,
    required this.keyPair,
    required this.fullDomain,
    required this.username,
  });

  final String invoice;
  final String paymentToken;
  final NostrKeyPairs keyPair;
  final String fullDomain;
  final String username;

  @override
  Widget build(BuildContext context) {
    final spaceHeight = 10.0;

    return BlocProvider<NpubCashPaymentInvoiceCubit>(
      create: (context) => NpubCashPaymentInvoiceCubit(
        invoice: invoice,
        paymentToken: paymentToken,
        fullDomain: fullDomain,
        keyPair: keyPair,
        username: username,
      ),
      child: ScaffoldMessenger(
        child: Builder(builder: (context) {
          return BlocListener<NpubCashPaymentInvoiceCubit,
              NpubCashPaymentInvoiceState>(
            listener: (context, state) {
              if (state.paidSuccessfully) {
                Navigator.of(context).pop(state.paidSuccessfully);
              }
            },
            child: MarginedBody(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: spaceHeight * 2,
                  ),
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: BottomSheetOptionsTitle(
                      title: "Pay this invoice to claim your username".tr(),
                    ),
                  ),
                  SizedBox(height: spaceHeight * 2),
                  Center(
                    child: QrImageView(
                      data: invoice.toUpperCase(),
                      version: QrVersions.auto,
                      size: 200,
                      backgroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: spaceHeight * 2),
                  CustomTextField(
                    readOnly: true,
                    isMultiline: true,
                    controller: TextEditingController(text: invoice),
                  ),
                  SizedBox(height: spaceHeight * 3),
                  SizedBox(
                    width: double.infinity,
                    child: RoundaboutButton(
                      icon: Icons.copy,
                      isOnlyBorder: true,
                      text: "Copy Invoice".tr(),
                      onTap: () {
                        AppUtils.instance.copy(
                          invoice,
                          onSuccess: () {
                            SnackBars.text(
                              context,
                              "copied".tr(),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: spaceHeight / 2),
                  SizedBox(
                    width: double.infinity,
                    child: RoundaboutButton(
                      text: "close".tr(),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(height: spaceHeight * 3),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

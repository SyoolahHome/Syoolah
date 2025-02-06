import 'dart:convert';

import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/lnd/widgets/npub_cash_proofs_claim_render.dart';
import 'package:ditto/presentation/profile_options/widgets/profile_title.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;

class MyNpubCashPaymentPage extends StatelessWidget {
  const MyNpubCashPaymentPage({
    super.key,
    required this.address,
  });

  final String address;
  @override
  Widget build(BuildContext context) {
    final spaceHeight = 10.0;

    return ScaffoldMessenger(
      child: Builder(
        builder: (context) {
          return MarginedBody(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: spaceHeight * 2,
                ),
                ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: BottomSheetOptionsTitle(
                    title: "My address",
                  ),
                ),
                SizedBox(height: spaceHeight * 2),
                Center(
                  child: QrImageView(
                    data: address,
                    version: QrVersions.auto,
                    size: 200,
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: spaceHeight * 2),
                CustomTextField(
                  readOnly: true,
                  isMultiline: true,
                  controller: TextEditingController(text: address),
                ),
                SizedBox(height: spaceHeight * 3),
                SizedBox(
                  width: double.infinity,
                  child: RoundaboutButton(
                    icon: Icons.copy,
                    isOnlyBorder: true,
                    text: "Copy my Lightning Address".tr(),
                    onTap: () {
                      AppUtils.instance.copy(
                        address,
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
                    text: "Generate Invoice".tr(),
                    isOnlyBorder: true,
                    onTap: () async {
                      try {
                        final split = address.split("@");
                        final localPart = split[0];
                        final domain = split[1];

                        final res = await http.get(
                          Uri.parse(
                            "https://$domain/.well-known/lnurlp/$localPart?amount=50000",
                          ),
                        );

                        if (res.statusCode == 200) {
                          final decoded =
                              jsonDecode(res.body) as Map<String, dynamic>;
                          final invoice = decoded["pr"];

                          await BottomSheetService.showNpubCashPaymentRequest(
                            context,
                            fullDomain: "https://$domain",
                            invoice: invoice,
                            paymentToken: "",
                            username: localPart,
                            keyPair: NostrKeyPairs(
                              private: LocalDatabase.instance.getPrivateKey()!,
                            ),
                          );
                        } else {
                          throw Exception("Failed to generate invoice");
                        }
                      } catch (e) {
                        SnackBars.text(
                          context,
                          "Failed to generate invoice",
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: spaceHeight / 2),
                SizedBox(
                  width: double.infinity,
                  child: RoundaboutButton(
                    text: "Close".tr(),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  height: spaceHeight * 2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:ditto/presentation/profile_options/widgets/profile_title.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

enum ProofsType { ln, cashu }

class NpubCashProofsClaimRender extends StatelessWidget {
  const NpubCashProofsClaimRender({
    super.key,
    required this.data,
    required this.statusCode,
    required this.keyPair,
    required this.fullDomain,
    required this.type,
  });

  final ProofsType type;

  final int statusCode;
  final Map<String, dynamic> data;
  final NostrKeyPairs keyPair;
  final String fullDomain;

  @override
  Widget build(BuildContext context) {
    final spaceHeight = 10.0;
    final demoCashuToken = "The cashu token here";

    return ScaffoldMessenger(
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
                title: switch (type) {
                  ProofsType.ln => "Lightning Proofs".tr(),
                  ProofsType.cashu => "CashU Proofs".tr(),
                },
              ),
            ),
            SizedBox(height: spaceHeight * 2),
            Builder(
              builder: (context) {
                final error = data["error"];
                final message = data["message"];

                if (error is bool && !error) {
                  return Text(message ?? "An Error Occured".tr());
                } else if (statusCode == 200) {
                  final dataField = data?["data"];
                  final token = dataField?["token"] ?? demoCashuToken;

                  switch (type) {
                    case ProofsType.ln:
                      final tokenAmount = 50000;
                      final lightningFees = 1000;

                      if (token != null &&
                          tokenAmount != null &&
                          lightningFees != null) {
                        return Column(
                          children: <Widget>[
                            HeadTitle(
                              title:
                                  "Please paste a lightning invoice here for ${tokenAmount - lightningFees} Sats"
                                      .tr(),
                            ),
                            SizedBox(
                              height: spaceHeight * 2,
                            ),
                            CustomTextField(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15,
                              ),
                              hint: "lnbc1...",
                              suffix: IconButton(
                                icon: Icon(Icons.copy),
                                onPressed: () {
                                  AppUtils.instance.copy(
                                    token,
                                    onSuccess: () {
                                      SnackBars.text(context, "Copied".tr());
                                    },
                                  );
                                },
                              ),
                              controller: TextEditingController(),
                            ),
                            SizedBox(
                              height: spaceHeight * 2,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: RoundaboutButton(
                                icon: Icons.flash_on,
                                isOnlyBorder: true,
                                text: "Pay Invoice".tr(),
                                onTap: () {
                                  SnackBars.text(
                                    context,
                                    "should launches cashu:token on native nitents so wallet can respond",
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Text("Nothing To Show here.");
                      }

                    case ProofsType.cashu:
                      return Column(
                        children: <Widget>[
                          HeadTitle(
                            title: "Token".tr(),
                          ),
                          SizedBox(
                            height: spaceHeight * 2,
                          ),
                          Center(
                            child: QrImageView(
                              data: token,
                              version: QrVersions.auto,
                              size: 200,
                              backgroundColor:
                                  Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          SizedBox(
                            height: spaceHeight * 2,
                          ),
                          CustomTextField(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 15,
                            ),
                            suffix: IconButton(
                              icon: Icon(Icons.copy),
                              onPressed: () {
                                AppUtils.instance.copy(
                                  token,
                                  onSuccess: () {
                                    SnackBars.text(context, "Copied".tr());
                                  },
                                );
                              },
                            ),
                            controller: TextEditingController(text: token),
                            isMultiline: true,
                            readOnly: true,
                          ),
                          SizedBox(
                            height: spaceHeight * 2,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: RoundaboutButton(
                              isOnlyBorder: true,
                              text: "Open In Wallet".tr(),
                              onTap: () {
                                SnackBars.text(
                                  context,
                                  "should launches cashu:token on native nitents so wallet can respond",
                                );
                              },
                            ),
                          ),
                        ],
                      );
                  }
                } else {
                  return Text("Nothing To Show here.");
                }
              },
            ),
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
      ),
    );
  }
}

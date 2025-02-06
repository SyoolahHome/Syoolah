import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/cubit/lnd_view_cubit.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:ditto/presentation/lnd/widgets/npub_cash_proofs_claim_render.dart';
import 'package:ditto/presentation/scan/widgets/title_section.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LndView extends StatelessWidget {
  const LndView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final heightSpace = 10.0;

    final privateKey = LocalDatabase.instance.getPrivateKey()!;

    final pair = NostrKeyPairs(private: privateKey);

    return BlocProvider<LndViewCubit>(
      create: (context) => LndViewCubit(
        keyPair: pair,
      ),
      child: Builder(
        builder: (context) {
          final cubit = context.read<LndViewCubit>();

          return BlocListener<LndViewCubit, LndViewState>(
            listener: (context, state) {
              if (state.success != null && state.success!.isNotEmpty) {
                SnackBars.text(context, state.success!);
              } else if (state.error != null && state.error!.isNotEmpty) {
                SnackBars.text(context, state.error!);
              }
            },
            child: MarginedBody(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: heightSpace),
                    HeadTitle(
                      title: "Wallet",
                      isForSection: true,
                      minimizeFontSizeBy: 5,
                    ),
                    SizedBox(height: heightSpace * 2),
                    Icon(
                      Icons.account_balance_wallet,
                      size: 60,
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(.5),
                    ),
                    SizedBox(height: heightSpace * 2),
                    BlocBuilder<LndViewCubit, LndViewState>(
                      builder: (context, state) {
                        final balance = state.balance;

                        return Card(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondary
                              .withOpacity(.1),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 20.0,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  HeadTitle(
                                    title: "Your Balance",
                                    isForSection: true,
                                    minimizeFontSizeBy: 7,
                                  ),
                                  SizedBox(height: heightSpace * 3),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        balance != null ? "$balance" : "--",
                                      ),
                                      SizedBox(
                                        width: heightSpace * 2,
                                      ),
                                      Text("Sats"),
                                    ].map((widg) {
                                      if (widg is Text && widg.data != null) {
                                        return Text(
                                          widg.data!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        );
                                      } else {
                                        return widg;
                                      }
                                    }).toList(),
                                  ),
                                  SizedBox(height: heightSpace * 3),
                                  Builder(builder: (context) {
                                    final pairs = [
                                      (
                                        Icons.flash_on,
                                        "Lightning",
                                        () {
                                          cubit.callClaim(
                                            context,
                                            type: ProofsType.ln,
                                          );
                                        }
                                      ),
                                      (
                                        Icons.abc,
                                        "Cashu",
                                        () {
                                          cubit.callClaim(
                                            context,
                                            type: ProofsType.cashu,
                                          );
                                        }
                                      ),
                                      (
                                        Icons.qr_code,
                                        "My payment Details",
                                        () {
                                          cubit.openPaymentView(context);
                                        }
                                      ),
                                    ];

                                    return Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: pairs.map((e) {
                                          return Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: heightSpace / 3,
                                              ),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: RoundaboutButton(
                                                  isOnlyBorder: true,
                                                  isRounded: true,
                                                  text: e.$2,
                                                  onTap: e.$3,
                                                  icon: e.$1,
                                                  iconSize: 22.5,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: heightSpace * 2),
                    BlocBuilder<LndViewCubit, LndViewState>(
                      builder: (context, state) {
                        final info = state.userInfo;

                        final domain = cubit.domain;
                        final localPart = info?.username ?? state.npub;
                        final fullAddress = "$localPart@$domain";

                        final localPartSummarized = info?.username ??
                            state.npub?.summarizeBothSides(10);

                        final addressSummarized =
                            "$localPartSummarized@$domain";

                        return Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(Icons.account_circle),
                                trailing: localPart != null
                                    ? IconButton(
                                        onPressed: () {
                                          AppUtils.instance.copy(
                                            fullAddress,
                                            onSuccess: () {
                                              SnackBars.text(
                                                context,
                                                "Copied!",
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.copy),
                                      )
                                    : null,
                                title: Text(
                                  addressSummarized,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.edit),
                                trailing: info?.username != null
                                    ? null
                                    : RoundaboutButton(
                                        onTap: () async {
                                          final username =
                                              await BottomSheetService
                                                  .tryClaimNpubCashUsername(
                                            context,
                                            domain: domain,
                                          );
                                          if (username == null ||
                                              username.isEmpty) {
                                            return;
                                          }

                                          await cubit.startClaimUserName(
                                            context,
                                            username,
                                          );
                                        },
                                        isSmall: true,
                                        isRounded: true,
                                        text: "Claim!",
                                      ),
                                title: Text(
                                  info?.username ?? "No username is claimed",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              if (info?.mintUrl != null &&
                                  info!.mintUrl!.isNotEmpty)
                                ListTile(
                                  trailing: RoundaboutButton(
                                    text: "Edit",
                                    isSmall: true,
                                    // isOnlyBorder: true,
                                    isRounded: true,
                                    onTap: () {
                                      cubit.editMintUrl(context);
                                    },
                                  ),
                                  leading: Icon(Icons.link),
                                  title: Text(
                                    info.mintUrl!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: heightSpace * 10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

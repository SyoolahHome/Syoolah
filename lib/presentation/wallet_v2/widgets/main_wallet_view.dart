import 'package:ditto/buisness_logic/cubit/wallet_version_two_cubit.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:ditto/presentation/wallet_v2/wallet_v2.dart';
import 'package:ditto/presentation/wallet_v2/widgets/info_tile.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

class MainWalletView extends StatelessWidget {
  const MainWalletView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WalletVersionTwoCubit>();
    final heightSpace = 10.0;

    return BlocBuilder<WalletVersionTwoCubit, WalletVersionTwoState>(
      builder: (context, state) {
        return Center(
          child: MarginedBody(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Builder(
                  builder: (context) {
                    final isBalanceLoading = state.isLoadingBalance;
                    final balance = state.balance;

                    final mainBalance = (balance?.balanceSat ?? 0) +
                        (balance?.feeCreditSat ?? 0);
                    final feeCreditSat = balance?.feeCreditSat ?? 0;

                    if (isBalanceLoading) {
                      return CircularProgressIndicator();
                    } else if (balance != null) {
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
                                      mainBalance != null
                                          ? "$mainBalance"
                                          : "--",
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
                                if (true ?? (feeCreditSat > 0)) ...[
                                  SizedBox(height: heightSpace),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 7.5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.color
                                          ?.withOpacity(.2),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Text(
                                      "Fee Credit: $feeCreditSat Sats",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                ],
                                SizedBox(height: heightSpace * 3),
                                Builder(
                                  builder: (context) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        BlocSelector<WalletVersionTwoCubit,
                                            WalletVersionTwoState, bool>(
                                          selector: (state) => state
                                              .isLoadingGeneratingBolt11Invoice,
                                          builder: (
                                            context,
                                            isLoadingGeneratingBolt11Invoice,
                                          ) {
                                            if (isLoadingGeneratingBolt11Invoice) {
                                              return Expanded(
                                                child: Center(
                                                  child: SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: .75,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }

                                            return Expanded(
                                              child: RoundaboutButton(
                                                text: "Deposit",
                                                icon: Icons.download,
                                                onTap: () {
                                                  cubit
                                                      .promptUserToSelectDepositMethod(
                                                    () => context,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(width: heightSpace),
                                        BlocSelector<WalletVersionTwoCubit,
                                                WalletVersionTwoState, bool>(
                                            selector: (state) =>
                                                state.isLoadingWithdraw,
                                            builder:
                                                (context, isLoadingWithdraw) {
                                              if (isLoadingWithdraw) {
                                                return Expanded(
                                                  child: Center(
                                                    child: SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: .75,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }

                                              return Expanded(
                                                child: RoundaboutButton(
                                                  text: "Withdraw",
                                                  icon: Icons.upload,
                                                  onTap: () {
                                                    cubit
                                                        .promptUserToWithdrawMethod(
                                                      () => context,
                                                    );
                                                  },
                                                ),
                                              );
                                            }),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),
                SizedBox(height: heightSpace * 2),
                SizedBox(
                  width: double.infinity,
                  child: RoundaboutButton(
                    isRounded: true,
                    isOnlyBorder: true,
                    text: "Check Node Info",
                    icon: Icons.info,
                    iconSize: 22.5,
                    onTap: state.nodeInfo != null
                        ? () {
                            cubit.showNodeInfo(context);
                          }
                        : null,
                  ),
                ),
                SizedBox(height: heightSpace * 3),
                Builder(
                  builder: (context) {
                    final isBolt12OfferLoading = state.isLoadingBolt12Offer;

                    if (isBolt12OfferLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: .75,
                        ),
                      );
                    }

                    final bolt12Offer = state.bolt12Offer;

                    return WalletV2InfoTile(
                      copiableValue: bolt12Offer,
                      title: "Bolt12 Offer",
                      leadingIconData: FlutterRemix.flashlight_line,
                      subtitle: bolt12Offer != null && bolt12Offer.isNotEmpty
                          ? bolt12Offer
                          : "--",
                    );
                  },
                ),
                Builder(
                  builder: (context) {
                    final isBip353Loading = state.isBip353Loading;
                    final bip353Username = state.bip353Identifier;

                    return WalletV2InfoTile(
                      copiableValue: bip353Username,
                      title: "Bip353 Username",
                      customTrailingBuilder: bip353Username == null
                          ? (context) {
                              return RoundaboutButton(
                                customWidget: isBip353Loading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: .75,
                                        ),
                                      )
                                    : null,
                                isSmall: true,
                                additonalFontSize: 2.5,
                                text: "Reserve New Username",
                                onTap: () {
                                  cubit.startCustomBip353UsrenameResreveProcess(
                                    onContextGet: () => context,
                                  );
                                },
                              );
                            }
                          : null,
                      leadingIconData: FlutterRemix.user_3_line,
                      subtitle: bip353Username,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:ditto/buisness_logic/cubit/wallet_two_history_cubit.dart';
import 'package:ditto/constants/app_enums.dart';
import 'package:ditto/presentation/wallet_v2/widgets/history_payment_tile_builder.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsTypeTabView extends StatelessWidget {
  const PaymentsTypeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WalletTwoHistoryCubit>();

    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BlocSelector<WalletTwoHistoryCubit, WalletTwoHistoryState, bool>(
            selector: (state) => state.isAll,
            builder: (context, isAll) {
              return SwitchListTile(
                title: Text(
                  "Show All",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                value: isAll,
                onChanged: (value) {
                  cubit.toggleShowingAll(value);
                },
              );
            },
          ),
          Flexible(
            child: TabBarView(
              children: cubit.tabs.map((tabType) {
                switch (tabType) {
                  case WalletV2HistoryPaymentsType.incoming:
                    return BlocBuilder<WalletTwoHistoryCubit,
                        WalletTwoHistoryState>(
                      builder: (context, state) {
                        final isIncomingLoading = state.isIncomingLoading;
                        final incomingPayments = state.incomingPayments;

                        if (isIncomingLoading) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (incomingPayments.isNotEmpty) {
                          return HistoryPaymentListViewBuilder(
                            payments: incomingPayments,
                            isCompletedResolver: (payment) {
                              return payment.isPaid ?? false;
                            },
                            dateToUseResolver: (payment) {
                              final asIntSinceEEpoch =
                                  payment.completedAt ?? payment.createdAt;

                              if (asIntSinceEEpoch == null) {
                                return null;
                              }

                              return DateTime.fromMillisecondsSinceEpoch(
                                asIntSinceEEpoch,
                              );
                            },
                            trailingIconData: Icons.arrow_downward,
                            subtitleBuilder: (payment) {
                              return payment.isPaid != null
                                  ? Text(
                                      "${payment.isPaid! ? 'Paid' : 'Not Paid'}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    )
                                  : null;
                            },
                            titleBuilder: (payment) {
                              return Text(
                                "${payment.receivedSat ?? '-'}",
                                style: Theme.of(context).textTheme.titleMedium,
                              );
                            },
                          );
                        }

                        return Center(
                          child: Text("No incoming payments, yet."),
                        );
                      },
                    );

                  case WalletV2HistoryPaymentsType.outgoing:
                    return BlocBuilder<WalletTwoHistoryCubit,
                        WalletTwoHistoryState>(
                      builder: (context, state) {
                        final isOutgoingLoading = state.isOutgoingLoading;
                        final outgoingPayments = state.outgoingPayments;

                        if (isOutgoingLoading) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (outgoingPayments.isNotEmpty) {
                          return HistoryPaymentListViewBuilder(
                            payments: outgoingPayments,
                            isCompletedResolver: (payment) {
                              return payment.isPaid ?? false;
                            },
                            dateToUseResolver: (payment) {
                              final asIntSinceEEpoch =
                                  payment.completedAt ?? payment.createdAt;

                              if (asIntSinceEEpoch == null) {
                                return null;
                              }

                              return DateTime.fromMillisecondsSinceEpoch(
                                asIntSinceEEpoch,
                              );
                            },
                            trailingIconData: Icons.arrow_upward,
                            subtitleBuilder: (payment) {
                              return payment.isPaid != null
                                  ? Text(
                                      "${payment.isPaid! ? 'Paid' : 'Not Paid'}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    )
                                  : null;
                            },
                            titleBuilder: (payment) {
                              return Text(
                                "${payment.sent ?? '-'}",
                                style: Theme.of(context).textTheme.titleMedium,
                              );
                            },
                          );
                        }

                        return Center(
                          child: Text("No outgoing payments, yet."),
                        );
                      },
                    );
                }
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:ditto/buisness_logic/cubit/wallet_two_history_cubit.dart';
import 'package:ditto/constants/app_enums.dart';
import 'package:ditto/presentation/wallet_v2/widgets/history_payments_type_tab_view.dart';
import 'package:ditto/presentation/wallet_v2/widgets/history_payments_type_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletTwoHistory extends StatelessWidget {
  const WalletTwoHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WalletTwoHistoryCubit>(
      create: (context) => WalletTwoHistoryCubit(
        tabs: [
          WalletV2HistoryPaymentsType.incoming,
          WalletV2HistoryPaymentsType.outgoing,
        ],
      ),
      child: Builder(
        builder: (context) {
          final cubit = context.read<WalletTwoHistoryCubit>();

          return DefaultTabController(
            length: cubit.tabs.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text("History"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      cubit.reloadRequests();
                    },
                  ),
                ],
              ),
              body: Column(
                children: <Widget>[
                  PaymentsTypeTabs(),
                  PaymentsTypeTabView(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

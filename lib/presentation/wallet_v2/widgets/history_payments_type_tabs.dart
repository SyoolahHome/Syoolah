import 'package:ditto/buisness_logic/cubit/wallet_two_history_cubit.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsTypeTabs extends StatelessWidget {
  const PaymentsTypeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WalletTwoHistoryCubit>();

    return TabBar(
      automaticIndicatorColorAdjustment: true,
      labelColor: Theme.of(context).textTheme.labelMedium?.color,
      overlayColor: WidgetStateProperty.all(
          Theme.of(context).colorScheme.onSecondary.withOpacity(.15)),
      tabs: cubit.tabs
          .map(
            (type) => Tab(
              child: Text(type.name.capitalized),
            ),
          )
          .toList(),
    );
  }
}

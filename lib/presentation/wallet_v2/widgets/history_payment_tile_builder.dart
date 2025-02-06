import 'package:ditto/model/pheonixD_payment.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter/material.dart';

class HistoryPaymentListViewBuilder<T extends PhoenixDPayment>
    extends StatelessWidget {
  const HistoryPaymentListViewBuilder({
    super.key,
    required this.titleBuilder,
    required this.subtitleBuilder,
    required this.payments,
    required this.trailingIconData,
    required this.dateToUseResolver,
    required this.isCompletedResolver,
  });

  final List<T> payments;
  final Widget Function(T payment) titleBuilder;
  final Widget? Function(T payment) subtitleBuilder;
  final DateTime? Function(T payment) dateToUseResolver;
  final IconData trailingIconData;
  final bool Function(T) isCompletedResolver;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: payments.length,
      itemBuilder: (context, index) {
        final payment = payments[index];

        final dateToUse = dateToUseResolver(payment);
        final isCompleted = isCompletedResolver(payment);

        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              Paths.historyPaymentDetails,
              arguments: {
                "payment": payment,
              },
            );
          },
          leading: Icon(
            trailingIconData,
            color: isCompleted
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.error,
            size: 22.5,
          ),
          title: titleBuilder(payment),
          subtitle: subtitleBuilder(payment),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                dateToUse != null ? "${dateToUse!.ago()}" : "-",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (isCompleted) ...[
                SizedBox(width: 20),
                Icon(
                  Icons.check_circle_outline_outlined,
                  color: Colors.green[700],
                  size: 20.5,
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}

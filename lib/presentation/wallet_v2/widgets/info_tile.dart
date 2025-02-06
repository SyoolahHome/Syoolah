import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:flutter/material.dart';

class WalletV2InfoTile extends StatelessWidget {
  const WalletV2InfoTile(
      {super.key,
      required this.subtitle,
      required this.title,
      required this.leadingIconData,
      this.copiableValue,
      this.customTrailingBuilder});

  final String? subtitle;
  final String title;
  final IconData leadingIconData;
  final String? copiableValue;

  final Widget Function(BuildContext context)? customTrailingBuilder;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(leadingIconData, size: 25),
        trailing: customTrailingBuilder?.call(context) ??
            (copiableValue != null
                ? RoundaboutButton(
                    text: 'Copy',
                    isSmall: true,
                    onTap: () {
                      AppUtils.instance.copy(
                        copiableValue!,
                        onSuccess: () {
                          SnackBars.text(
                            context,
                            "Copied Successfully to Clipboard!",
                          );
                        },
                      );
                    },
                  )
                : null),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.color
                          ?.withOpacity(.75),
                    ),
              )
            : null);
  }
}

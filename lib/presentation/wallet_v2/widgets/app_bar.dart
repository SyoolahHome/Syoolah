import 'package:ditto/buisness_logic/cubit/wallet_version_two_cubit.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

class MainWalletViewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const MainWalletViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WalletVersionTwoCubit>();

    return AppBar(
      actions: <Widget>[
        RoundaboutButton(
          onTap: () {
            cubit.resetWallet();
          },
          icon: FlutterRemix.refresh_line,
          iconSize: 20.5,
          isRounded: true,
          isSmall: true,
          isOnlyBorder: true,
          text: 'Reset',
          additonalFontSize: 4.5,
        ),
        RoundaboutButton(
          onTap: () {
            cubit.reloadRequests();
          },
          icon: FlutterRemix.refresh_line,
          iconSize: 20.5,
          isRounded: true,
          isSmall: true,
          isOnlyBorder: true,
          text: 'Refresh',
          additonalFontSize: 4.5,
        ),
        SizedBox(width: 10.5),
        RoundaboutButton(
          onTap: () {
            Navigator.pushNamed(
              context,
              Paths.walletV2History,
            );
          },
          icon: FlutterRemix.history_line,
          iconSize: 20.5,
          isRounded: true,
          isSmall: true,
          text: 'My History',
          additonalFontSize: 4.5,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 1);
}

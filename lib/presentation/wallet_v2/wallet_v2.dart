import 'package:ditto/buisness_logic/cubit/wallet_version_two_cubit.dart';
import 'package:ditto/constants/abstractions/abstractions.dart';
import 'package:ditto/presentation/wallet_v2/widgets/app_bar.dart';
import 'package:ditto/presentation/wallet_v2/widgets/main_wallet_view.dart';
import 'package:ditto/presentation/wallet_v2/widgets/manual_server_url_input.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletVersionTwo extends BottomBarScreen {
  const WalletVersionTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletVersionTwoCubit(),
      child: FutureBuilder(
        future: Future.delayed(
          Duration(milliseconds: 250),
          () => 0,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return BlocBuilder<WalletVersionTwoCubit, WalletVersionTwoState>(
            builder: (context, state) {
              final isLoadingServer = state.isLoadingServer;
              final serverbaseUrl = state.walletServerBaseUrl;

              if (isLoadingServer) {
                return const Center(child: CircularProgressIndicator());
              } else if (serverbaseUrl != null && serverbaseUrl.isNotEmpty) {
                return Scaffold(
                  appBar: MainWalletViewAppBar(),
                  body: MainWalletView(),
                );
              } else {
                return ManualServerUrlInput();
              }
            },
          );
        },
      ),
    );
  }
}

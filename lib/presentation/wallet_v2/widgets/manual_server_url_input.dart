import 'package:ditto/buisness_logic/cubit/wallet_version_two_cubit.dart';
import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManualServerUrlInput extends StatelessWidget {
  const ManualServerUrlInput({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WalletVersionTwoCubit>();

    return MarginedBody(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomTextField(
            controller: cubit.manualServerBaseUrlController,
            hint: "server base url",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
          ),
          SizedBox(height: 20),
          CustomTextField(
            controller: cubit.walletApiKeyPasswordController,
            hint: "password",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: BlocSelector<WalletVersionTwoCubit, WalletVersionTwoState,
                bool>(
              selector: (state) => state.allowApplyButtonForServer,
              builder: (context, allowApplyButtonForServer) {
                return RoundaboutButton(
                  isRounded: true,
                  text: "Apply & Save",
                  onTap: true ?? allowApplyButtonForServer
                      ? cubit.applyManualServerUrl
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

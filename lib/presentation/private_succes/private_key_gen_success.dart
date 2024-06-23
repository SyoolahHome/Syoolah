import 'package:ditto/buisness_logic/private_key_gen_success_cubit/private_key_gen_success_cubit.dart';
import 'package:ditto/presentation/current_user_keys/widgets/danger_box.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/private_succes/widgets/backup_mnemonic_button.dart';
import 'package:ditto/presentation/private_succes/widgets/button.dart';
import 'package:ditto/presentation/private_succes/widgets/key_section.dart';
import 'package:ditto/presentation/private_succes/widgets/success_icon.dart';
import 'package:ditto/presentation/private_succes/widgets/success_text.dart';
import 'package:ditto/services/utils/alerts_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../general/pattern_widget.dart';

class PrivateKeyGenSuccess extends StatelessWidget {
  const PrivateKeyGenSuccess({super.key, this.onCopy, this.customText});

  final VoidCallback? onCopy;
  final String? customText;
  @override
  Widget build(BuildContext context) {
    const heightSeparator = 10.0;

    return BlocProvider<PrivateKeyGenSuccessCubit>(
      create: (context) => PrivateKeyGenSuccessCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<PrivateKeyGenSuccessCubit>();

        return PatternScaffold(
          body: MarginedBody(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Spacer(),
                const SuccessIcon(),
                const SizedBox(height: heightSeparator),
                SuccessText(customText: customText),
                const Spacer(),
                DangerBox(
                  bgColor: Theme.of(context)
                      .colorScheme
                      .errorContainer
                      .withOpacity(.45),
                  messageText: "copyItNowDanger".tr(),
                  titleText: "warning".tr(),
                ),
                const SizedBox(height: heightSeparator * 4),
                KeySection(onCopy: onCopy),
                const SizedBox(height: heightSeparator * 4),
                BlocSelector<PrivateKeyGenSuccessCubit,
                    PrivateKeyGenSuccessState, String?>(
                  selector: (state) => state.mnemonic,
                  builder: (context, mnemonic) {
                    if (mnemonic == null || mnemonic.isEmpty) {
                      return const SizedBox.shrink();
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BackUpMnemonicButton(
                            mnemonic: mnemonic,
                            onBackedUpSuccess: () {
                              cubit.markAsBackedUp();
                            },
                          ),
                          const SizedBox(height: heightSeparator),
                        ],
                      );
                    }
                  },
                ),
                StartButton(
                  onTap: () {
                    if (cubit.state.mnemonicBackedUp) {
                      onCopy!();
                    } else {
                      AlertsService.confirmDialog(
                        title: "You didn't back up the seed phrase!",
                        content:
                            "Are you sure you want to continue without backing up the seed phrase?",
                        context: context,
                        cancelTextt: "No",
                        confirmText: "Yes",
                        onConfirm: () async {
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  },
                ),
                const SizedBox(height: heightSeparator * 2),
              ],
            ),
          ),
        );
      }),
    );
  }
}

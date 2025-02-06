import 'package:ditto/buisness_logic/cubit/wallet_v2_withd_raw_input_cubit.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletV2WithdrawInput extends StatelessWidget {
  const WalletV2WithdrawInput({super.key});

  @override
  Widget build(BuildContext context) {
    final heightSpace = 10.0;

    final mq = MediaQuery.of(context);

    final possibleOptionHints = <(IconData icon, String hint, String example)>[
      (
        Icons.check_circle_outline_outlined,
        "Bolt11 Invoice",
        "lnbc1pwr7v9xpp5qeif6fs...",
      ),
      (
        Icons.check_circle_outline_outlined,
        "Lightning/Bip353 Address",
        "anas@syoolah.me",
      ),
      (
        Icons.check_circle_outline_outlined,
        "Bolt12 Offer",
        "lno1zrxq8pjw7qjlm68mtp7e3yvxee...",
      ),
    ];

    return Padding(
      padding: EdgeInsets.only(
        bottom: mq.viewInsets.bottom,
      ),
      child: BlocProvider<WalletV2WithdRawInputCubit>(
        create: (context) => WalletV2WithdRawInputCubit(),
        child: Builder(
          builder: (context) {
            final cubit = context.read<WalletV2WithdRawInputCubit>();

            return MarginedBody(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: heightSpace * 2),
                  BottomSheetTitleWithIconButton(
                    title: "Input receiver information",
                  ),
                  SizedBox(height: heightSpace / 2),
                  ...possibleOptionHints.map(
                    (optionHintRec) {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        leading: Icon(
                          optionHintRec.$1,
                          color: Colors.green[600],
                        ),
                        title: Text(
                          optionHintRec.$2,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          optionHintRec.$3,
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.color
                                        ?.withOpacity(0.6),
                                  ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: heightSpace * 2),
                  CustomTextField(
                    controller: cubit.inputController,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    hint: "Input here...",
                    maxLines: 6,
                  ),
                  SizedBox(height: heightSpace * 2),
                  SizedBox(
                    width: double.infinity,
                    child: RoundaboutButton(
                      onTap: () {
                        final input = cubit.inputController.text.trim();

                        Navigator.pop(context, input);
                      },
                      text: "Confirm",
                    ),
                  ),
                  SizedBox(height: heightSpace * 4),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

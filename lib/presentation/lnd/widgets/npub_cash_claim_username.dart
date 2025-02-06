import 'package:ditto/buisness_logic/cubit/npub_cash_claim_username_cubit.dart';
import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/profile_options/widgets/profile_title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NpubCashClaimUsername extends StatelessWidget {
  const NpubCashClaimUsername({
    super.key,
    required this.domain,
  });

  final String domain;

  @override
  Widget build(BuildContext context) {
    final spaceHeight = 10.0;

    return BlocProvider<NpubCashClaimUsernameCubit>(
      create: (context) => NpubCashClaimUsernameCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<NpubCashClaimUsernameCubit>();

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: MarginedBody(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: spaceHeight * 2,
                ),
                ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: BottomSheetOptionsTitle(
                    title: "Claim Your own Unique username/address".tr(),
                  ),
                ),
                SizedBox(height: spaceHeight * 2),
                CustomTextField(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  suffix: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text("@$domain"),
                  ),
                  isMultiline: false,
                  maxLines: 1,
                  hint: "Username here!",
                  controller: cubit.controller,
                ),
                SizedBox(height: spaceHeight * 2),
                BlocSelector<NpubCashClaimUsernameCubit,
                    NpubCashClaimUsernameState, String?>(
                  selector: (state) => state.username,
                  builder: (context, username) {
                    return SizedBox(
                      width: double.infinity,
                      child: RoundaboutButton(
                        onTap: username != null && username!.isNotEmpty
                            ? () {
                                Navigator.of(context).pop(username);
                              }
                            : null,
                        text: "Submit!",
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: spaceHeight * 2,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

import 'package:ditto/buisness_logic/cubit/mint_url_prompt_cubit.dart';
import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/profile_options/widgets/profile_title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MintUrlPrompt extends StatelessWidget {
  const MintUrlPrompt({
    super.key,
    required this.defaultMint,
  });

  final String? defaultMint;

  @override
  Widget build(BuildContext context) {
    final spaceHeight = 10.0;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: BlocProvider<MintUrlPromptCubit>(
        create: (context) => MintUrlPromptCubit(
          defaultMint: defaultMint,
        ),
        child: Builder(
          builder: (context) {
            final cubit = context.read<MintUrlPromptCubit>();

            return MarginedBody(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: spaceHeight * 2,
                  ),
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: BottomSheetOptionsTitle(
                      title: "Modify mint URL",
                    ),
                  ),
                  SizedBox(height: spaceHeight * 2),
                  CustomTextField(
                    controller: cubit.controller,
                    contentPadding: EdgeInsets.all(10),
                  ),
                  SizedBox(height: spaceHeight * 2),
                  SizedBox(
                    width: double.infinity,
                    child: RoundaboutButton(
                      isOnlyBorder: true,
                      text: "Close".tr(),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(height: spaceHeight / 2),
                  BlocSelector<MintUrlPromptCubit, MintUrlPromptState, String?>(
                    selector: (state) => state.mintInput,
                    builder: (context, mintInput) {
                      return SizedBox(
                        width: double.infinity,
                        child: RoundaboutButton(
                          text: "Continue".tr(),
                          onTap: mintInput != null && mintInput.isNotEmpty
                              ? () {
                                  Navigator.of(context).pop(mintInput);
                                }
                              : null,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: spaceHeight * 2,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

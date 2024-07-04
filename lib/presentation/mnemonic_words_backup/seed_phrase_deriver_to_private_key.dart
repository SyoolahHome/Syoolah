import 'package:ditto/buisness_logic/cubit/seed_phrase_prompt_and_private_key_deriver_cubit.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/mnemonic_words_backup/widgets/words_grid_view.dart';
import 'package:ditto/presentation/profile_options/widgets/profile_title.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeedPhrasePromptAndPrivateKeyDeriver extends StatelessWidget {
  const SeedPhrasePromptAndPrivateKeyDeriver({super.key});

  @override
  Widget build(BuildContext context) {
    final emptyWordsKeys = List.generate(12, (index) => "${index}");
    final spaceHeight = 10.0;

    return BlocProvider<SeedPhrasePromptAndPrivateKeyDeriverCubit>(
      create: (context) => SeedPhrasePromptAndPrivateKeyDeriverCubit(
        controllersKeys: emptyWordsKeys,
      ),
      child: Builder(builder: (context) {
        final cubit = context.read<SeedPhrasePromptAndPrivateKeyDeriverCubit>();

        return BlocListener<SeedPhrasePromptAndPrivateKeyDeriverCubit,
            SeedPhrasePromptAndPrivateKeyDeriverState>(
          listener: (context, state) {
            final pv = state.privateKey;

            if (pv != null && pv.isNotEmpty) {
              Navigator.of(context).pop(pv);
            } else if (state.error != null) {
              SnackBars.text(context, state.error!);
            }
          },
          child: MarginedBody(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height:
                      (spaceHeight * 5) + MediaQuery.of(context).padding.top,
                ),
                ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: BottomSheetOptionsTitle(
                    title: "Write Your Seed Phrase".tr(),
                  ),
                ),
                SizedBox(height: spaceHeight * 2),
                Expanded(
                  child: MnemonicWordsGridView(
                    words: cubit.controllersKeys,
                    onIsEnabled: (_) {
                      return true;
                    },
                    onIsVisible: (word) {
                      return true;
                    },
                    onGetWordController: (word) {
                      return cubit.controllersMap[word];
                    },
                  ),
                ),
                SizedBox(height: spaceHeight * 2),
                SizedBox(
                  width: double.infinity,
                  child: RoundaboutButton(
                    text: "login".tr(),
                    onTap: () {
                      cubit.submit();
                    },
                  ),
                ),
                SizedBox(height: spaceHeight * 2),
              ],
            ),
          ),
        );
      }),
    );
  }
}

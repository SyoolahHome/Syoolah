import 'package:ditto/buisness_logic/cubit/mnemonic_words_back_up_cubit.dart';
import 'package:ditto/presentation/chat/widgets/text_field.dart';
import 'package:ditto/presentation/general/pattern_widget.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/mnemonic_words_backup/widgets/words_grid_view.dart';
import 'package:ditto/presentation/profile_options/widgets/profile_title.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MnemonicWordsBackUp extends StatelessWidget {
  const MnemonicWordsBackUp({
    super.key,
    required this.mnemonic,
  });

  final String mnemonic;

  @override
  Widget build(BuildContext context) {
    final spaceHeight = 10.0;

    return BlocProvider<MnemonicWordsBackUpCubit>(
      create: (context) => MnemonicWordsBackUpCubit(
        mnemonic: mnemonic,
      ),
      child: Builder(
        builder: (context) {
          final cubit = context.read<MnemonicWordsBackUpCubit>();

          return PatternScaffold(
            body: MarginedBody(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height:
                        (spaceHeight * 5) + MediaQuery.of(context).padding.top,
                  ),
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: BottomSheetOptionsTitle(
                      title: "Back up My Seed Phrase".tr(),
                    ),
                  ),
                  SizedBox(height: spaceHeight * 2),
                  
                  Expanded(
                    child: BlocBuilder<MnemonicWordsBackUpCubit,
                        MnemonicWordsBackUpState>(
                      builder: (context, state) {
                        final words = state.mnemonicWords;
                        final visibleWords = state.visibleWords;

                        return MnemonicWordsGridView(
                          words: words,
                          onIsEnabled: (word) {
                            return state.isConfirmationProcessStarted &&
                                state.randomWordsToInputManually.contains(word);
                          },
                          onIsVisible: (word) {
                            return visibleWords.contains(word);
                          },
                          onEyeIconTap: (index) {
                            cubit.toggleVisibility(index);
                          },
                          onGetWordController: (word) {
                            return cubit.controllers[word];
                          },
                        );
                      },
                    ),
                  ),
                  BlocSelector<MnemonicWordsBackUpCubit,
                      MnemonicWordsBackUpState, bool>(
                    selector: (state) => state.isConfirmationProcessStarted,
                    builder: (context, isConfirmationProcessStarted) {
                      if (isConfirmationProcessStarted) {
                        return BlocSelector<MnemonicWordsBackUpCubit,
                            MnemonicWordsBackUpState, bool>(
                          selector: (state) =>
                              state.randomWordsToInputManually.isEmpty,
                          builder: (context, confirmed) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Please input the missing words above and confirm.",
                                ),
                                SizedBox(height: spaceHeight),
                                SizedBox(
                                  width: double.infinity,
                                  child: RoundaboutButton(
                                    text: "Confirm",
                                    onTap: confirmed
                                        ? () {
                                            Navigator.of(context).pop(true);
                                          }
                                        : null,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            BlocSelector<MnemonicWordsBackUpCubit,
                                MnemonicWordsBackUpState, bool>(
                              selector: (state) {
                                return state.visibleWords.length ==
                                    state.mnemonicWords.length;
                              },
                              builder: (context, allShown) {
                                return RoundaboutButton(
                                  text: allShown
                                      ? "Hide All Words".tr()
                                      : "Show All Words".tr(),
                                  onTap: () {
                                    cubit.toggleAllVisibility(allShown);
                                  },
                                );
                              },
                            ),
                            RoundaboutButton(
                              text: "I Confirm I Have Written Down My Phrase"
                                  .tr(),
                              onTap: () {
                                cubit.startConfirmationProcess();
                              },
                            ),
                          ]
                              .map(
                                (e) => SizedBox(
                                  width: double.infinity,
                                  child: e,
                                ),
                              )
                              .toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

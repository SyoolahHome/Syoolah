import 'package:ditto/buisness_logic/cubit/mnemonic_words_back_up_cubit.dart';
import 'package:ditto/presentation/chat/widgets/text_field.dart';
import 'package:ditto/presentation/general/pattern_widget.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
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
                  SizedBox(height: spaceHeight * 3),
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: BottomSheetOptionsTitle(
                      title: "BackupMnemonic".tr(),
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<MnemonicWordsBackUpCubit,
                        MnemonicWordsBackUpState>(
                      builder: (context, state) {
                        final words = state.mnemonicWords;
                        final visibleWords = state.visibleWords;

                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: words.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3.5,
                          ),
                          itemBuilder: (context, index) {
                            final word = words[index];
                            final isVisible = visibleWords.contains(word);
                            final enabled = state
                                    .isConfirmationProcessStarted &&
                                state.randomWordsToInputManually.contains(word);

                            return Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                TextField(
                                  enabled: enabled,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  controller: cubit.controllers[word],
                                  decoration: InputDecoration(
                                    prefix: Text(
                                      "${index + 1}.  ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      cubit.toggleVisibility(index);
                                    },
                                    child: Icon(
                                      isVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                              ],
                            );
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
                            return SizedBox(
                              width: double.infinity,
                              child: RoundaboutButton(
                                text: "Confirm",
                                onTap: confirmed
                                    ? () {
                                        Navigator.of(context).pop(true);
                                      }
                                    : null,
                              ),
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
                              text: "I wrote them down".tr(),
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

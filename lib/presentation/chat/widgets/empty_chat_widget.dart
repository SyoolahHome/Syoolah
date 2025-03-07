import 'dart:math';
import 'package:ditto/presentation/chat/widgets/chat_section.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/chat/chat_cubit.dart';

class EmptyChatWidget extends StatelessWidget {
  const EmptyChatWidget({
    super.key,
    required this.recommendedQuestions,
  });
  final List<String> recommendedQuestions;

  @override
  Widget build(BuildContext context) {
    List<T> takeRandomThree<T>(List<T> takeRandomThree) {
      final random = Random();
      final randomThree = <T>[];
      while (randomThree.length < 3) {
        final randomIndex = random.nextInt(takeRandomThree.length);
        final randomItem = takeRandomThree[randomIndex];
        if (!randomThree.contains(randomItem)) {
          randomThree.add(randomItem);
        }
      }

      return randomThree;
    }

    final randomChoosenThree = takeRandomThree<String>(recommendedQuestions);
    const height = 10.0;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          const MessageSection(),
          const Spacer(),

          const Center(child: OrDivider(onlyDivider: true)),
          // SizedBox(height: height * 4),
          // Text(
          //   "startConversation".tr() + ":",
          //   style: Theme.of(context).textTheme.bodyMedium,
          // ),
          const SizedBox(height: height),
          MarginedBody(
            child: Text(
              "suggestionToGetStarted".tr(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(.6),
                  ),
            ),
          ),
          // const SizedBox(height: height / 2),
          MarginedBody(
            child: Column(
              children: AnimateList(
                interval: 200.ms,
                effects: const <Effect>[
                  SlideEffect(begin: Offset(0, 0.5)),
                  FadeEffect()
                ],
                children: randomChoosenThree.map(
                  (current) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                        borderRadius: BorderRadius.circular(8.0),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            final cubit = context.read<ChatCubit>();
                            cubit.userMessageController!.text = current;
                            cubit.sendMessageByCurrentUser();
                          },
                          highlightColor: Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.1),
                          splashColor: Colors.transparent,
                          child: Container(
                            padding: MarginedBody.defaultMargin +
                                const EdgeInsets.symmetric(vertical: 15.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    current,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                const Icon(
                                  FlutterRemix.bubble_chart_line,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          // ...List.generate(
          //   randomChoosenThree.length,
          //   (index) {
          //     final current = randomChoosenThree[index];

          //     return Container(
          //       width: double.infinity,
          //       margin: EdgeInsets.only(top: 16.0),
          //       child: Material(
          //         color: Theme.of(context).colorScheme.onTertiaryContainer,
          //         borderRadius: BorderRadius.circular(8.0),
          //         clipBehavior: Clip.hardEdge,
          //         child: InkWell(
          //           onTap: () {
          //             final cubit = context.read<ChatCubit>();
          //             cubit.userMessageController!.text = current;
          //             cubit.sendMessageByCurrentUser();
          //           },
          //           highlightColor: Theme.of(context)
          //               .colorScheme
          //               .background
          //               .withOpacity(0.1),
          //           splashColor: Colors.transparent,
          //           child: Container(
          //             padding: MarginedBody.defaultMargin +
          //                 EdgeInsets.symmetric(
          //                   vertical: 15.0,
          //                 ),
          //             child: Row(
          //               children: <Widget>[
          //                 Text(
          //                   current,
          //                   style: Theme.of(context).textTheme.bodyMedium,
          //                 ),
          //                 const Spacer(),
          //                 Icon(
          //                   FlutterRemix.bubble_chart_line,
          //                   size: 20,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
          // SizedBox(height: height * 4),
          // Text(
          //   "AskDirectlyFromTextField".tr() + ":",
          //   style: Theme.of(context).textTheme.bodyMedium,
          // ),
        ],
      ),
    );
  }
}

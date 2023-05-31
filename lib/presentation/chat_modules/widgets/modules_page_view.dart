import 'package:ditto/buisness_logic/cubit/chat_modules_cubit.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatModulesPageView extends StatelessWidget {
  const ChatModulesPageView({
    super.key,
    required this.showAtIndex,
    required this.onTap,
  });

  final int showAtIndex;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatModulesCubit>();
    final modulesItems = cubit.modulesItems;
    const height = 10.0;

    return SizedBox(
      height: 175,
      child: PageView.builder(
        allowImplicitScrolling: false,
        physics: NeverScrollableScrollPhysics(),
        controller: cubit.pageController,
        itemCount: modulesItems.length,
        itemBuilder: (context, index) {
          final item = modulesItems[index];

          return Animate(
            effects: <Effect>[
              ScaleEffect(
                duration: Animate.defaultDuration * 10,
                begin: Offset(0.95, 0.95),
                end: Offset(1.05, 1.05),
                alignment: Alignment.center,
              ),
              SlideEffect(
                duration: Animate.defaultDuration * 10,
                begin: Offset(0, 0.05),
                end: Offset.zero,
              ),
            ],
            onComplete: (controller) => controller.repeat(reverse: true),
            child: GestureDetector(
              onTap: onTap,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Theme.of(context).colorScheme.onPrimary,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              Paths.chat,
                              arguments: {
                                "chatModduleItem": item,
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            child: Icon(item.icon),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: height * 1.5),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    // return GridView.builder(
    //   physics: NeverScrollableScrollPhysics(),
    //   padding: EdgeInsets.zero,
    //   shrinkWrap: true,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     mainAxisSpacing: MarginedBody.defaultMargin.horizontal / 2,
    //     crossAxisSpacing: MarginedBody.defaultMargin.horizontal / 2,
    //     childAspectRatio: 1.05,
    //   ),
    //   itemCount: modulesItems.length,
    //   itemBuilder: (context, index) {
    //     final current = modulesItems[index];

    //     return Container(
    //       padding: EdgeInsets.all(16.0),
    //       decoration: BoxDecoration(
    //         color: Theme.of(context).colorScheme.onTertiaryContainer,
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           SizedBox(height: height),
    //           HeadTitle(title: current.title),
    //           SizedBox(height: height),
    //           Text(
    //             current.subtitle,
    //             style: Theme.of(context).textTheme.labelSmall?.copyWith(
    //                   fontWeight: FontWeight.w400,
    //                 ),
    //           ),
    //           Spacer(),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: <Widget>[
    //               Icon(
    //                 current.icon,
    //                 color: Theme.of(context).primaryColor,
    //                 size: 27,
    //               ),
    //               MunawarahButton(
    //                 onTap: () {
    //                   Navigator.of(context).pushNamed(
    //                     Paths.chat,
    //                     arguments: {"chatModduleItem": current},
    //                   );
    //                 },
    //                 text: "start".tr(),
    //                 isSmall: true,
    //               )
    //             ],
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}

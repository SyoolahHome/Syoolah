import 'package:ditto/buisness_logic/cubit/chat_modules_cubit.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatModulesGridView extends StatelessWidget {
  const ChatModulesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatModulesCubit>();
    final modulesItems = cubit.modulesItems;
    const height = 10.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: modulesItems.map(
        (item) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                Paths.chat,
                arguments: {
                  "chatModduleItem": item,
                },
              );
            },
            child: Column(
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
                        padding: const EdgeInsets.all(17.5),
                        child: Icon(item.icon),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: height),
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            ),
          );
        },
      ).toList(),
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

import 'package:ditto/presentation/chat_modules/widgets/modules_page_view.dart';
import 'package:ditto/presentation/chat_modules/widgets/sub_title.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/chat_modules/chat_modules_cubit.dart';
import '../../constants/abstractions/abstractions.dart';
import '../../services/utils/paths.dart';
import '../general/pattern_widget.dart';
import '../general/widget/bottom_sheet_title_with_button.dart';
import '../general/widget/button.dart';

class ChatModules extends BottomBarScreen {
  const ChatModules({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 20.0;

    return BlocProvider<ChatModulesCubit>(
      create: (context) => ChatModulesCubit(),
      child: PatternScaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: height,
            ),
            MarginedBody(
              child: BottomSheetTitleWithIconButton(
                title: "f1OnDuty".tr().titleCapitalized,
              ),
            ),
            const SizedBox(height: height),
            MarginedBody(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // HeadTitle(
                  //   title: ,
                  //   isForSection: true,
                  // ),
                  // const SizedBox(height: height / 2),
                  ChatModulesSubtitle(text: "f1OnDutySubtitle".tr()),
                ],
              ),
            ),
            const SizedBox(height: height * 2),
            BlocSelector<ChatModulesCubit, ChatModulesState, double>(
              selector: (state) => state.sliderValue,
              builder: (context, sliderValue) {
                final cubit = context.read<ChatModulesCubit>();
                final currentViewedLevel =
                    cubit.modulesItems[sliderValue.toInt()];
                void _triggerChatNavigation() {
                  Navigator.of(context).pop();

                  Navigator.of(context).pushNamed(
                    Paths.chat,
                    arguments: {
                      "chatModduleItem": currentViewedLevel,
                    },
                  );
                }

                return Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: ChatModulesPageView(
                          showAtIndex: sliderValue.toInt(),
                          onTap: _triggerChatNavigation,
                        ),
                      ),
                      MarginedBody(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: height * 2,
                              child: AnimatedSwitcher(
                                duration: Animate.defaultDuration,
                                child: Text(
                                  currentViewedLevel.title,
                                  key: ValueKey(currentViewedLevel.subtitle),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background
                                            .withOpacity(.6),
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.normal,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 4),
                            Slider(
                              value: sliderValue,
                              onChanged: (value) {
                                cubit.changeSliderValue(value);
                              },
                              min: 0.0,
                              max: cubit.modulesItems.length.toDouble() - 1,
                              divisions: cubit.modulesItems.length - 1,
                              label: currentViewedLevel.title,
                            ),
                            SizedBox(height: height),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: SakhirButton(
                                text: "start".tr(),
                                onTap: _triggerChatNavigation,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: height),
          ],
        ),
      ),
    );
  }
}

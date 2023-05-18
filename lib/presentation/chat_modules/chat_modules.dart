import 'package:ditto/buisness_logic/cubit/chat_modules_cubit.dart';
import 'package:ditto/presentation/chat_modules/widgets/modules_grid_view.dart';
import 'package:ditto/presentation/chat_modules/widgets/sub_title.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatModules extends StatelessWidget {
  const ChatModules({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 20.0;

    return BlocProvider<ChatModulesCubit>(
      create: (context) => ChatModulesCubit(),
      child: Scaffold(
        body: MarginedBody(
          child: Column(
            children: <Widget>[
              const SizedBox(height: kToolbarHeight),
              const SizedBox(height: height),
              HeadTitle(title: "imamOnDuty".tr(), isForSection: true),
              const SizedBox(height: height / 2),
              ChatModulesSubtitle(text: "imamOnDutySubtitle2".tr()),
              const Spacer(),
              const ChatModulesGridView(),
              const Spacer(),
              const SizedBox(height: kToolbarHeight),
              const SizedBox(height: height),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:ditto/presentation/chat_modules/widgets/sub_title.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/cubit/chat_modules_cubit.dart';
import 'widgets/modules_grid_view.dart';

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
              SizedBox(height: kToolbarHeight),
              SizedBox(height: height),
              HeadTitle(title: "encryptYourDuaa".tr(), isForSection: true),
              SizedBox(height: height / 2),
              ChatModulesSubtitle(text: "imamOnDutySubtitle".tr()),
              Spacer(),
              ChatModulesGridView(),
              Spacer(),
              SizedBox(height: kToolbarHeight),
              SizedBox(height: height),
            ],
          ),
        ),
      ),
    );
  }
}

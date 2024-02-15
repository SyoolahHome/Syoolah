import 'package:ditto/constants/abstractions/abstractions.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/translation/translation_cubit.dart';
import 'widget/app_bar.dart';
import 'widgets/input_area.dart';
import 'widgets/output_area.dart';
import 'widgets/translate_button.dart';
import 'widgets/translation_options.dart';

class Translation extends BottomBarScreen {
  const Translation({super.key});

  @override
  Widget build(BuildContext context) {
    final height = 10.0;

    final screenWidth = MediaQuery.of(context).size.width;

    final screenHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).padding.top;

    return BlocProvider<TranslationCubit>(
      create: (context) => TranslationCubit(),
      child: MarginedBody(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(screenWidth, screenHeight)),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: CustomAppBar(),
              body: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: height * 2),
                    InputArea(),
                    SizedBox(height: height * 2),
                    TranslationOptions(),
                    SizedBox(height: height * 2),
                    OutputArea(),
                    Spacer(),
                    TranslateButton(),
                    SizedBox(height: height * 2),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../general/widget/title.dart';
import 'widgets/app_bar.dart';
import 'widgets/button.dart';
import 'widgets/key_field.dart';
import 'package:easy_localization/easy_localization.dart';

class ExistentSignUp extends StatelessWidget {
  const ExistentSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const heightSeparator = 10.0;

    return Scaffold(
      appBar: const CustomAppBar(),
      // backgroundColor: AppColors.teal,
      body: MarginedBody(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: heightSeparator * 2),
              Spacer(),
              Animate(
                effects: const <Effect>[
                  FadeEffect(),
                  SlideEffect(
                    begin: Offset(-0.25, 0),
                  ),
                ],
                child: HeadTitle(
                  title: "existentKeyAuth".tr(),
                  isForSection: true,
                ),
              ),
              Spacer(
                flex: 2,
              ),
              KeyField(),
              SizedBox(height: heightSeparator),
              CustomButton(),
              SizedBox(height: heightSeparator * 3),
            ],
          ),
        ),
      ),
    );
  }
}

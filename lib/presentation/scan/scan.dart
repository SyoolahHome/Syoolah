import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../general/widget/title.dart';
import 'widgets/app_bar.dart';
import 'widgets/button.dart';
import 'widgets/key_field.dart';
import 'package:easy_localization/easy_localization.dart';

import 'widgets/title_section.dart';

class ExistentSignUp extends StatelessWidget {
  const ExistentSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const heightSeparator = 10.0;

    return Scaffold(
      appBar: const CustomAppBar(),
      // backgroundColor: Theme.of(context).primaryColor,
      body: MarginedBody(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: heightSeparator * 2),
              Spacer(),
              TitleSection(),
              Spacer(flex: 2),
              KeyField(),
              SizedBox(height: heightSeparator * 2),
              CustomButton(),
              SizedBox(height: heightSeparator * 3),
            ],
          ),
        ),
      ),
    );
  }
}

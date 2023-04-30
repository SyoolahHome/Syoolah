import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';

import 'widgets/app_bar.dart';
import 'widgets/button.dart';
import 'widgets/key_field.dart';

class ExistentSignUp extends StatelessWidget {
  const ExistentSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const heightSeparator = 10.0;

    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: AppColors.teal,
      body: MarginedBody(
        child: Center(
          child: Column(
            children: const <Widget>[
              SizedBox(height: heightSeparator * 2),
              Spacer(),
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

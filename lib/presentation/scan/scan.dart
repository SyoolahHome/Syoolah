import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/scan/widgets/app_bar.dart';
import 'package:ditto/presentation/scan/widgets/button.dart';
import 'package:ditto/presentation/scan/widgets/key_field.dart';
import 'package:ditto/presentation/scan/widgets/title_section.dart';
import 'package:flutter/material.dart';

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
            children: const <Widget>[
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

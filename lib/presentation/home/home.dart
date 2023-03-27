import 'package:ditto/presentation/home/widgets/logo.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widget/margined_body.dart';
import 'widgets/go_button.dart';
import 'widgets/name_field.dart';
import 'widgets/or_divider.dart';
import 'widgets/private_key_label.dart';
import 'widgets/title.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const heightSeparator = 10.0;

    return Scaffold(
      backgroundColor: AppColors.teal,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            minHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: MarginedBody(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                SizedBox(height: heightSeparator * 3),
                Spacer(),
                Logo(),
                // ScreenTitle(),
                Spacer(),
                NameField(),
                SizedBox(height: heightSeparator),
                GoButton(),
                SizedBox(height: heightSeparator * 1.5),
                OrDivider(),
                SizedBox(height: heightSeparator * 1.5),
                PrivateKeyLabel(),
                SizedBox(height: heightSeparator * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

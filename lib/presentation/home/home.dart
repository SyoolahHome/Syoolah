import 'package:ditto/presentation/home/widgets/logo.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../general/auth_app_handler.dart';
import '../general/widget/margined_body.dart';
import 'widgets/go_button.dart';
import 'widgets/name_field.dart';
import 'widgets/or_divider.dart';
import 'widgets/private_key_label.dart';

class KeyAuth extends StatelessWidget {
  const KeyAuth({super.key});

  @override
  Widget build(BuildContext context) {
    const heightSeparator = 10.0;
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return AuthenticationStreamHandler(
      child: Scaffold(
        backgroundColor: AppColors.teal,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: screenHeight,
              minHeight: screenHeight,
              maxWidth: screenWidth,
              minWidth: screenWidth,
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
      ),
    );
  }
}

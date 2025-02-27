import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/presentation/about_app/widgets/about_app_content.dart';
import 'package:ditto/presentation/about_app/widgets/custom_app_bar.dart';
import 'package:ditto/presentation/about_app/widgets/title.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:flutter/material.dart';

class AboutRoundabout extends StatelessWidget {
  const AboutRoundabout({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: MarginedBody(
        margin: MarginedBody.defaultMargin +
            const EdgeInsets.symmetric(horizontal: 5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              SizedBox(height: height * 3),
              AboutRoundaboutTitle(),
              Center(child: OrDivider(color: AppColors.black)),
              SizedBox(height: height * 3),
              AboutRoundaboutContent(),
              SizedBox(height: height * 3),
            ],
          ),
        ),
      ),
    );
  }
}

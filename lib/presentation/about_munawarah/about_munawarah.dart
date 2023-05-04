import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import 'widgets/about_munawarah_content.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/title.dart';

class AboutMunawarah extends StatelessWidget {
  const AboutMunawarah({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: MarginedBody(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              SizedBox(height: height * 3),
              AboutMunawarahTitle(),
              SizedBox(height: height * 3),
              Center(
                child: OrDivider(onlyDivider: false, color: AppColors.black),
              ),
              SizedBox(height: height * 3),
              AboutMunawarahContent(),
              SizedBox(height: height * 3),
            ],
          ),
        ),
        margin: MarginedBody.defaultMargin +
            const EdgeInsets.symmetric(horizontal: 5),
      ),
    );
  }
}

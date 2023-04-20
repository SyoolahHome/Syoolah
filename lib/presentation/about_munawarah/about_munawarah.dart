import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/home/widgets/or_divider.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import 'widgets/about_content.dart';
import 'widgets/app_bar.dart';
import 'widgets/title.dart';

class AboutMunawarah extends StatelessWidget {
  const AboutMunawarah({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return Scaffold(
      backgroundColor: AppColors.black,
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
              AboutMunawarahTitle(),
              SizedBox(height: height * 3),
              Center(child: OrDivider(onlyDivider: false, color: Colors.white)),
              SizedBox(height: height * 3),
              AboutMunawarahContent(),
              SizedBox(height: height * 3),
            ],
          ),
        ),
      ),
    );
  }
}

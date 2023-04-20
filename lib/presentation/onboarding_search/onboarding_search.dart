import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../onboarding/widgets/search_icon.dart';
import 'widgets/app_bar.dart';
import 'widgets/search_field.dart';

class OnBoardingSearch extends StatelessWidget {
  const OnBoardingSearch({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: AppColors.black,
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {},
        child: const SearchIcon(color: Colors.white),
      ),
      body: MarginedBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: height * 3),
            Text(
              AppStrings.identifierOrPuKey,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.white ?? Theme.of(context).hintColor,
                  ),
            ),
            const SizedBox(height: height),
            const SearchField(),
          ],
        ),
      ),
    );
  }
}

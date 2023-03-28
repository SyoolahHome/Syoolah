import 'package:ditto/constants/colors.dart';
import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../bottom_bar_screen/Bottom_bar_screen.dart';

class GoButton extends StatelessWidget {
  const GoButton({
    super.key,
    this.padding = const EdgeInsets.all(10),
  });

  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    final scaffoldColor =
        context.findAncestorWidgetOfExactType<Scaffold>()!.backgroundColor;

    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BottomBar()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white.withOpacity(0.95),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              AppStrings.continueText,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: scaffoldColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: Icon(
            FlutterRemix.arrow_right_fill,
            color: scaffoldColor,
          ),
        )
      ],
    );
  }
}

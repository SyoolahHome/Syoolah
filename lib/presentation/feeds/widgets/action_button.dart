import 'package:ditto/presentation/feeds/widgets/reset_button.dart';
import 'package:ditto/presentation/feeds/widgets/search_button.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    const width = 10.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Expanded(child: ResetButton()),
        SizedBox(width: width),
        Expanded(child: SearchButton()),
      ],
    );
  }
}

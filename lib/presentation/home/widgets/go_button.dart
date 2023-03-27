import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../../BottomBar.dart';

class GoButton extends StatelessWidget {
  const GoButton({
    super.key,
    this.padding = const EdgeInsets.all(10),
  });

  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.tealAccent,
      ),
      padding: padding,
      child: InkWell(
        child: const Text(
          AppStrings.go,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomBar()),
          );
        },
      ),
    );
  }
}

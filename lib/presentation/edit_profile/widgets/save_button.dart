import 'package:flutter/material.dart';

import '../../bottom_bar_screen/Bottom_bar_screen.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.cyan,
      ),
      padding: const EdgeInsets.all(10),
      child: InkWell(
        child: const Center(
          child: Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BottomBar()));
        },
      ),
    );
  }
}

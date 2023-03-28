import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          InkWell(
            child: const Icon(Icons.arrow_back, size: 26),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 30),
          const Text(
            "Edit Profile",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

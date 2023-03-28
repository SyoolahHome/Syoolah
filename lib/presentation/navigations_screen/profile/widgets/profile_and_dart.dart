import 'package:flutter/material.dart';

import '../../../../edit_Profile.dart';

class ProfileAndEdit extends StatelessWidget {
  const ProfileAndEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        const CircleAvatar(
          radius: 45,
          backgroundImage: AssetImage("assets/profile.jpeg"),
        ),
        Container(
          width: 100,
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white70,
              border: Border.all(color: Colors.blue)),
          child: Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfile(),
                  ),
                );
              },
              child: const Text(
                "Edit",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }
}

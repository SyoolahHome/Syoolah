import 'package:flutter/material.dart';

import '../../../edit_profile/edit_Profile.dart';

class ProfileAndEdit extends StatelessWidget {
  const ProfileAndEdit({
    super.key,
    required this.profileUrl,
    required this.onEditTap,
  });

  final String profileUrl;
  final VoidCallback onEditTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        CircleAvatar(
          radius: 45,
          backgroundImage: NetworkImage(
            profileUrl,
          ),
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
              onTap: onEditTap,
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

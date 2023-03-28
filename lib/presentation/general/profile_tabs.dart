import 'package:flutter/material.dart';

abstract class GeneralProfileTabs {
  static Map<int, Widget> get profileTabs => <int, Widget>{
        0: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Posts",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white70,
              ),
            )),
        1: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Replies",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white70,
            ),
          ),
        ),
        2: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Likes",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white70))),
      };
}

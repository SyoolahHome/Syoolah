import 'package:flutter/material.dart';

class ProfileWidgetBuilder extends StatelessWidget {
  const ProfileWidgetBuilder({
    super.key,
    required this.profileSegmentationValue,
  });

  final int profileSegmentationValue;
  @override
  Widget build(BuildContext context) {
    switch (profileSegmentationValue) {
      case 0:
        return const Center(
            child: Text("Posts Loading ...", style: TextStyle(fontSize: 25)));
        break;
      case 1:
        return const Center(
          child: Text(
            "Replies Loading ...",
            style: TextStyle(fontSize: 25),
          ),
        );
        break;
      case 2:
        return const Center(
          child: Text(
            "Loading ...",
            style: TextStyle(fontSize: 25),
          ),
        );
        break;
      default:
        return const Center(
          child: Text(
            "Something Wrong",
            style: TextStyle(fontSize: 25),
          ),
        );
    }
  }
}

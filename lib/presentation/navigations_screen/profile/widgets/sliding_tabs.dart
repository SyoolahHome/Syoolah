import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlidingTabs extends StatelessWidget {
  const SlidingTabs({
    super.key,
    required this.onValueChanged,
    required this.profileSegmentationValue,
    required this.profileTabs,
  });

  final void Function(int?) onValueChanged;
  final int profileSegmentationValue;
  final Map<int, Widget> profileTabs;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoSlidingSegmentedControl(
        groupValue: profileSegmentationValue,
        thumbColor: Colors.grey,
        backgroundColor: Colors.black,
        onValueChanged: onValueChanged,
        children: profileTabs,
      ),
    );
  }
}

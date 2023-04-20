import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../services/utils/paths.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({
    super.key,
    this.color,
  });
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'onBoardingSearch',
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          Navigator.of(context).pushNamed(Paths.onBoardingSearch);
        },
        splashFactory: NoSplash.splashFactory,
        child: Container(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Theme.of(context).primaryColor.withOpacity(0.2),
          ),
          child: Icon(
            FlutterRemix.search_line,
            color: color ?? Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

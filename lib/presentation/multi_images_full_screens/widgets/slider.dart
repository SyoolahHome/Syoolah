import 'package:ditto/presentation/bottom_bar_screen/widgets/bottom_bar.dart';
import 'package:ditto/presentation/general/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagesSlider extends StatelessWidget {
  const ImagesSlider({
    super.key,
    required this.imageLinks,
  });

  final List<String> imageLinks;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final halfOfScreenWidget = mediaQuery.size.width / 2;
    final sizeOfSliderImageCard = 50.0;
    final marginOfFirstMargin =
        halfOfScreenWidget - (sizeOfSliderImageCard / 2);

    return TabBar(
      isScrollable: true,
      indicatorColor: Colors.transparent,
      indicator: null,
      dividerColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      tabs: imageLinks.indexedMap(
        (index, imageLink) {
          final bool isFirst = index == 0;

          return Container(
            margin: EdgeInsets.only(left: isFirst ? marginOfFirstMargin : 0),
            child: CustomCachedNetworkImage(
              url: imageLink,
              shouldOpenFullViewOnTap: false,
              size: sizeOfSliderImageCard,
              fit: BoxFit.fill,
            ),
          );
        },
      ).toList(),
    );
  }
}

import 'package:ditto/presentation/general/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageContent extends StatelessWidget {
  const ImageContent({
    super.key,
    required this.link,
    required this.heroTag,
    this.size,
    this.fit = BoxFit.none,
    this.shouldOpenFullViewOnTap = true,
    this.borderRadiusValue = 10,
  });

  final String link;
  final String heroTag;
  final double? size;
  final BoxFit fit;
  final bool shouldOpenFullViewOnTap;
  final double borderRadiusValue;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue)),
      child: CustomCachedNetworkImage(
        url: link,
        size: size,
        fit: fit,
        shouldOpenFullViewOnTap: shouldOpenFullViewOnTap,
      ),
    );
  }
}

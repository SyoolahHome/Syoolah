import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../custom_cached_network_image.dart';

class ImageContent extends StatelessWidget {
  const ImageContent({
    super.key,
    required this.link,
    required this.heroTag,
    this.size,
    this.fit = BoxFit.none,
  });

  final String link;
  final String heroTag;
  final double? size;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: link + heroTag,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: CustomCachedNetworkImage(
          url: link,
          size: size,
          fit: fit,
        ),
      ),
    );
  }
}

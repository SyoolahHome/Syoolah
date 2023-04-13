import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
        child: CachedNetworkImage(
          imageUrl: link,
          height: size,
          width: size,
          fit: fit,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          placeholder: (context, url) => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/image_full_view..dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.url,
    this.size,
    this.fit,
    required this.shouldOpenFullViewOnTap,
  });

  final String url;
  final double? size;
  final BoxFit? fit;
  final bool shouldOpenFullViewOnTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: shouldOpenFullViewOnTap
          ? () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ImageFullView(heroTag: url, link: url);
                  },
                ),
              );
            }
          : null,
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: fit ?? BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: SizedBox(
            width: 10,
            height: 10,
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.background,
              strokeWidth: 0.55,
              value: downloadProgress.progress,
            ),
          ),
        ),
        fadeInDuration: Animate.defaultDuration,
        fadeOutDuration: Animate.defaultDuration,
        placeholderFadeInDuration: Animate.defaultDuration,
      ),
    );
  }
}

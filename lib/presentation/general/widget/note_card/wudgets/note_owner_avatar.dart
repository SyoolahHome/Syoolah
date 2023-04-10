import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NoteOwnerAvatar extends StatelessWidget {
  const NoteOwnerAvatar({
    super.key,
    required this.avatarUrl,
  });

  final String avatarUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: CachedNetworkImage(
        imageUrl: avatarUrl,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.picture,
  });

  final String picture;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: picture,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: CachedNetworkImage(
          imageUrl: picture,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          width: 75,
          height: 75,
        ),
      ),
    );
  }
}

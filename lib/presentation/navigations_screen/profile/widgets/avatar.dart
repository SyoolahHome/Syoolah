import 'package:ditto/presentation/general/custom_cached_network_image.dart';
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
        child: CustomCachedNetworkImage(
          url: picture,
          size: 75,
        ),
      ),
    );
  }
}

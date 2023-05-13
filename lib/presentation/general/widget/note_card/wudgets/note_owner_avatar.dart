import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../constants/app_colors.dart';
import '../../../custom_cached_network_image.dart';
import 'image_full_view..dart';

class NoteOwnerAvatar extends StatelessWidget {
  const NoteOwnerAvatar({super.key, required this.avatarUrl, this.size});

  final String avatarUrl;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: size != null ? size! / 40 : 1,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).colorScheme.onPrimary),
        child: CustomCachedNetworkImage(url: avatarUrl),
      ),
    );
  }
}

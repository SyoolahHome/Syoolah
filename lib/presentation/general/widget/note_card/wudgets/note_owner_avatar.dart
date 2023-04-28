import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import 'image_full_view..dart';

class NoteOwnerAvatar extends StatelessWidget {
  const NoteOwnerAvatar({super.key, required this.avatarUrl, this.size});

  final String avatarUrl;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: size != null ? size! / 40 : 1,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ImageFullView(
                  heroTag: avatarUrl,
                  link: avatarUrl,
                );
              },
            ),
          );
        },
        child: Container(
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
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.black,
                  strokeWidth: 0.75,
                  value: downloadProgress.progress,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

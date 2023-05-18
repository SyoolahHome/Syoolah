import 'package:ditto/presentation/general/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

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
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).colorScheme.onPrimary,),
        child: CustomCachedNetworkImage(url: avatarUrl),
      ),
    );
  }
}

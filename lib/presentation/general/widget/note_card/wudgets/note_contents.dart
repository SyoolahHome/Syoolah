import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/hashtagable.dart';

import '../../../../../constants/colors.dart';

class NoteContents extends StatelessWidget {
  const NoteContents({
    super.key,
    required this.imageLinks,
    required this.text,
    required this.heroTag,
  });

  final String text;
  final String heroTag;
  final List<String> imageLinks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 5),
        HashTagText(
          text: text,
          textAlign: TextAlign.left,
          basicStyle: Theme.of(context).textTheme.labelLarge!,
          decoratedStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: AppColors.teal,
              ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: imageLinks.map(
                (link) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ImageFullView(
                            heroTag: heroTag,
                            link: link,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: ImageContent(
                        heroTag: heroTag,
                        link: link,
                        size: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ).toList()),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

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

class ImageFullView extends StatelessWidget {
  const ImageFullView({
    super.key,
    required this.link,
    required this.heroTag,
  });

  final String link;
  final String heroTag;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ImageContent(
            heroTag: heroTag,
            link: link,
            fit: BoxFit.fitWidth,
          ),
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}

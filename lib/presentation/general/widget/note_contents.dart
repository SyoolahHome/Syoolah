import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/colors.dart';

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
        Text(
          text,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 15),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ImageContent(
                          heroTag: heroTag,
                          link: link,
                          size: 150,
                        ),
                      ),
                    );
                  },
                ).toList()),
          ),
        ),
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
  });

  final String link;
  final String heroTag;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: CachedNetworkImage(
        imageUrl: link,
        height: size,
        width: size,
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
            heroTag: heroTag ,
            link: link,
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

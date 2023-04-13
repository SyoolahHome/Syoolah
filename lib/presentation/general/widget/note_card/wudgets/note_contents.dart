import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/hashtagable.dart';

import '../../../../../constants/colors.dart';
import 'image_content.dart';
import 'image_full_view..dart';

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

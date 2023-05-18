import 'package:ditto/presentation/general/widget/note_card/wudgets/image_content.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/note_youtube_player.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/hashtagable.dart';

class NoteContents extends StatelessWidget {
  const NoteContents({
    super.key,
    required this.imageLinks,
    required this.text,
    required this.heroTag,
    required this.youtubeVideosLinks,
  });

  final String text;
  final String heroTag;
  final List<String> imageLinks;
  final List<String> youtubeVideosLinks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // const SizedBox(height: 5),
        HashTagText(
          text: text.capitalized,
          textAlign: TextAlign.left,
          basicStyle: Theme.of(context).textTheme.labelLarge!,
          decoratedStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
        const SizedBox(height: 10),
        if (imageLinks.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: imageLinks.map(
                  (link) {
                    return GestureDetector(
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
                ).toList(),),
          ),
        // const SizedBox(height: 20),
        if (youtubeVideosLinks.isNotEmpty)
          NoteYoutubePlayer(url: youtubeVideosLinks.first),
        const SizedBox(height: 20),
      ],
    );
  }
}

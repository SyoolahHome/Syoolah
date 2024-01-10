import 'package:ditto/presentation/bottom_bar_screen/widgets/bottom_bar.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/image_content.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/note_youtube_player.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable_v3/hashtagable.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../multi_images_full_screens/multi_images_full_screens.dart';

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
                color: AppColors.blue,
              ),
        ),
        const SizedBox(height: 10),
        if (imageLinks.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: imageLinks.indexedMap(
                (index, link) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ImagesFullView(
                            imageLinks: imageLinks,
                            initialIndex: index,
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
                        shouldOpenFullViewOnTap: false,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        // const SizedBox(height: 20),
        if (youtubeVideosLinks.isNotEmpty)
          NoteYoutubePlayer(url: youtubeVideosLinks.first),
        const SizedBox(height: 20),
      ],
    );
  }
}

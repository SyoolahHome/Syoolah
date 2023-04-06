import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditto/constants/colors.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:nostr_client/nostr_client.dart';

import '../../../model/note.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
  });

  final Note note;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MarginedBody.defaultMargin.horizontal / 2,
        vertical: MarginedBody.defaultMargin.horizontal / 4,
      ),
      margin: EdgeInsets.symmetric(
        vertical: MarginedBody.defaultMargin.horizontal / 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.lighGrey,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(
            note.noteOnly,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: note.imageLinks.map(
              (link) {
                return Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: CachedNetworkImage(
                      imageUrl: link,
                    ));
              },
            ).toList()),
          ),
        ],
      ),
    );
  }
}

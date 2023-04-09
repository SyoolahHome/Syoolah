import 'package:ditto/model/note.dart';
import 'package:flutter/material.dart';

import '../../presentation/general/widget/note_comments_section.dart';
import '../../presentation/new_post/add_new_post.dart';

abstract class BottomSheetService {
  static showCreatePostBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return const AddNewPost();
      },
    );
  }

  static noteComments(
    BuildContext context, {
    required Note note,
  }) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container();
      },
    );
  }
}

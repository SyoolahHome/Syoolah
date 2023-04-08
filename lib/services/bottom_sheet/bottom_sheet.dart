import 'package:flutter/material.dart';

import '../../presentation/new_post/add_new_post.dart';

abstract class BottomSheetService {
  static showCreatePostBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
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
}

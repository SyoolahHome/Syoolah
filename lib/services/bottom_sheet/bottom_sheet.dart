import 'package:flutter/material.dart';

import '../../presentation/new_post/add_new_post.dart';

abstract class BottomSheetService {
  static showCreatePostBottomSheet(BuildContext context) {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return const AddNewPost();
      },
    );
  }
}

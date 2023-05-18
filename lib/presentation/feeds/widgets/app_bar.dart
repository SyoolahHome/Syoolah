import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.feedName,
  });

  final String feedName;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
          FlutterRemix.arrow_left_fill,
          size: 20,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            NostrService.instance.sendTextNoteFromCurrentUser(
              text: """
Hello there!!!!

https://www.youtube.com/watch?v=PMpNhbMjDj0
              """,
              tags: [
                ["t", AppConfigs.categories.first.name]
              ],
            );
          },
          icon: const Icon(FlutterRemix.add_line),
        ),
        IconButton(
          icon: const Icon(
            FlutterRemix.search_2_line,
            size: 20,
          ),
          onPressed: () {
            context.read<GlobalFeedCubit>().showSearch(context);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

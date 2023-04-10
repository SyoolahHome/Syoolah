import 'package:ditto/presentation/feeds/feed_page.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:flutter/material.dart';

import '../../constants/strings.dart';

class DuaFeed extends StatelessWidget {
  const DuaFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralFeed(
      feedName: AppStrings.dua,
      feedPostsStream: NostrService.instance.duaFeedStream(),
    );
  }
}